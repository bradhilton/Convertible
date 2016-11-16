//
//  Initializable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

import Reflection

public protocol Initializable : DataInitializable, JsonInitializable, KeyMapping {}

extension Initializable {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        return try initializeWithJson(JsonValue.initializeWithData(data, options: options), options: options)
    }
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        switch json {
        case .dictionary(let dictionary): return try initializeWithDictionary(dictionary, options: options)
        default: throw ConvertibleError.cannotCreateType(type: type(of: self), fromJson: json)
        }
    }
    
    static func initializeWithDictionary(_ dictionary: [NSString: JsonValue], options: [ConvertibleOption]) throws -> Self {
        var properties = Dictionary<String, Any>()
        var missingKeys = [String]()
        for field in try Reflection.properties(self) {
            guard let mappedKey = mappedKeyForPropertyKey(field.reducedKey) else { continue }
            if let value = dictionary[mappedKey as NSString] {
                guard let jsonInitializable = field.type as? JsonInitializable.Type else {
                    throw ConvertibleError.notJsonInitializable(type: field.type)
                }
                properties[field.reducedKey] = try jsonInitializable.initializeWithJson(value, options: options)
            } else if let nilLiteralConvertible = field.type as? ExpressibleByNilLiteral.Type {
                properties[field.reducedKey] = nilLiteralConvertible.init(nilLiteral: ())
            } else {
                missingKeys.append(mappedKey)
            }
        }
        guard missingKeys.count == 0 else {
            throw ConvertibleError.missingRequiredJsonKeys(keys: missingKeys)
        }
        return try initializeWithPropertyDictionary(properties)
    }
    
    static func initializeWithPropertyDictionary(_ dictionary: [String: Any]) throws -> Self {
        return try construct { field in
            if let value = dictionary[field.reducedKey] {
                return value
            } else if let type = field.type as? ExpressibleByNilLiteral.Type {
                return type.init(nilLiteral: ())
            } else {
                throw ConvertibleError.unknownError
            }
        }
    }
    
}
