//
//  Initializable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

import Allegro

public protocol Initializable : DataInitializable, JsonInitializable, KeyMapping {}

extension Initializable {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try initializeWithJson(JsonValue.initializeWithData(data, options: options), options: options)
    }
    
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
    
}
