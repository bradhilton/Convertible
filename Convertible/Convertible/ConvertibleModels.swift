//
//  Convertible2.swift
//  Convertible
//
//  Created by Bradley Hilton on 9/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation
import Allegro

extension Field {
    var reducedName: String {
        return name.componentsSeparatedByString(".")[0]
    }
}

extension Property {
    var reducedKey: String {
        return key.componentsSeparatedByString(".")[0]
    }
}

public protocol Initializable : DataInitializable, JsonInitializable, KeyMapping {}

public protocol Serializable : DataSerializable, JsonSerializable, KeyMapping {}

public protocol Convertible : Initializable, Serializable {}

extension Initializable {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        switch json {
        case .Dictionary(let dictionary): return try initializeWithDictionary(dictionary, options: options)
        default: throw ConvertibleError.CannotCreateType(type: self.dynamicType, fromJson: json)
        }
    }
    
    static func initializeWithDictionary(dictionary: [NSString: JsonValue], options: [ConvertibleOption]) throws -> Self {
        var properties = Dictionary<String, Any>()
        var missingKeys = [String]()
        for field in try fieldsForType(self) {
            guard let mappedKey = mappedKeyForPropertyKey(field.reducedName) else { continue }
            if let value = dictionary[mappedKey] {
                guard let jsonInitializable = field.type as? JsonInitializable.Type else {
                    throw ConvertibleError.NotJsonInitializable(type: field.type)
                }
                properties[field.reducedName] = try jsonInitializable.initializeWithJson(value, options: options)
            } else if let nilLiteralConvertible = field.type as? NilLiteralConvertible.Type {
                properties[field.reducedName] = nilLiteralConvertible.init(nilLiteral: ())
            } else {
                missingKeys.append(mappedKey)
            }
        }
        guard missingKeys.count == 0 else {
            throw ConvertibleError.MissingRequiredJsonKeys(keys: missingKeys)
        }
        return try initializeWithPropertyDictionary(properties)
    }
    
    static func initializeWithPropertyDictionary(dictionary: [String: Any]) throws -> Self {
        return try constructType { field in
            if let value = dictionary[field.reducedName] {
                return value
            } else if let type = field.type as? NilLiteralConvertible.Type {
                return type.init(nilLiteral: ())
            } else {
                throw ConvertibleError.UnknownError
            }
        }
    }
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try initializeWithJson(JsonValue.initializeWithData(data, options: options), options: options)
    }
    
}

extension Serializable {
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        var dictionary = [NSString : JsonValue]()
        for property in try propertiesForInstance(self) {
            guard let mappedKey = self.dynamicType.mappedKeyForPropertyKey(property.reducedKey) else { continue }
            guard let serializable = property.value as? JsonSerializable else {
                throw ConvertibleError.NotJsonSerializable(type: property.value.dynamicType)
            }
            let json = try serializable.serializeToJsonWithOptions(options)
            switch json {
            case .Null(_): break
            default: dictionary[mappedKey] = json
            }
        }
        return JsonValue.Dictionary(dictionary)
    }
    
}




