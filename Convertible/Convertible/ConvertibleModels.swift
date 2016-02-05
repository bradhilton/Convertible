//
//  Convertible2.swift
//  Convertible
//
//  Created by Bradley Hilton on 9/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation
import Allegro

extension Int : Allegro.Property {}

public protocol Initializable : DataInitializable, JsonInitializable, KeyMapping {
    init()
}

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
        var properties = Dictionary<String, Allegro.Property>()
        var missingKeys = [String]()
        for field in try fieldsForType(self) {
            if let value = dictionary[mappedKeyForPropertyKey(field.name)] {
                guard let jsonInitializable = field.type as? JsonInitializable.Type else {
                    throw ConvertibleError.NotJsonInitializable(type: field.type)
                }
                properties[field.name] = try jsonInitializable.initializeWithJson(value, options: options)
            } else if let nilLiteralConvertible = field.type as? protocol<Allegro.Property, NilLiteralConvertible>.Type {
                properties[field.name] = nilLiteralConvertible.init(nilLiteral: ())
            } else if field.type is NilLiteralConvertible.Type {
                throw ConvertibleError.NotPropertyType(type: field.type)
            } else {
                missingKeys.append(mappedKeyForPropertyKey(field.name))
            }
        }
        guard missingKeys.count == 0 else {
            throw ConvertibleError.MissingRequiredJsonKeys(keys: missingKeys)
        }
        return try initializeWithPropertyDictionary(properties)
    }
    
    static func initializeWithPropertyDictionary(dictionary: [String: Allegro.Property]) throws -> Self {
        return try constructType { field in
            return dictionary[field.name] ?? 0
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
        for child in Mirror(reflecting: self).children {
            guard let serializable = child.value as? JsonSerializable, label = child.label else {
                throw ConvertibleError.NotJsonSerializable(type: child.value.dynamicType)
            }
            dictionary[self.dynamicType.mappedKeyForPropertyKey(label)] = try serializable.serializeToJsonWithOptions(options)
        }
        return JsonValue.Dictionary(dictionary)
    }
    
}




