//
//  Dictionary+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/15/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Dictionary : DataModelConvertible {}

extension Dictionary : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Dictionary {
        switch json {
        case .Dictionary(let dictionary): return try resultFromDictionary(dictionary, options: options)
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    static func resultFromDictionary(dictionary: [NSString : JsonValue], options: [ConvertibleOption]) throws -> Dictionary {
        var result = Dictionary<Key, Value>()
        for (key, value) in dictionary {
            guard let key = key as? Key else {
                throw ConvertibleError.NotStringType(type: Key.self)
            }
            guard let valueType = Value.self as? JsonInitializable.Type,
                let value = try valueType.initializeWithJson(value, options: options) as? Value else {
                throw ConvertibleError.NotJsonInitializable(type: Value.self)
            }
            result[key] = value
        }
        return result
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        var dictionary = [NSString : JsonValue]()
        for (key, value) in self {
            guard let key = key as? NSString else {
                throw ConvertibleError.NotStringType(type: Key.self)
            }
            guard let value = value as? JsonSerializable else {
                throw ConvertibleError.NotJsonSerializable(type: Value.self)
            }
            let object = try value.serializeToJsonWithOptions(options)
            dictionary[key] = object
        }
        return JsonValue.Dictionary(dictionary)
    }
    
}