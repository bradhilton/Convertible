//
//  JsonModelConvertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/22/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol JsonModelConvertible : JsonConvertible, JsonModelInitializable, JsonModelSerializable {}

public protocol JsonModelSerializable : JsonSerializable {}

extension JsonModelSerializable {
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        var dictionary = [NSString:JsonValue]()
        for key in allKeys(self) {
            guard let serializable = key.value as? JsonSerializable else {
                throw ConvertibleError.NotJsonSerializable(type: key.valueType)
            }
            dictionary[key.mappedKey] = try serializable.serializeToJsonWithOptions(options)
        }
        return JsonValue.Dictionary(dictionary)
    }
    
}

public protocol JsonModelInitializable : JsonInitializable {
    
    init()
    mutating func setValue(value: Any?, forKey key: Key) throws
    
}

extension JsonModelInitializable {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        var object = self.init()
        try object.loadJson(json, options: options)
        return object
    }
    
    mutating func loadJson(json: JsonValue, options: [ConvertibleOption]) throws {
        switch json {
        case .Dictionary(let dictionary):
            try checkDictionaryForMissingRequiredKeys(dictionary)
            try loadDictionary(dictionary, options: options)
            try checkForNilRequiredKeys()
            return
        default:
            throw ConvertibleError.CannotCreateType(type: self.dynamicType, fromJson: json)
        }
    }
    
    mutating func loadDictionary(dictionary: [NSString:JsonValue], options: [ConvertibleOption]) throws {
        for key in allKeys(self) {
            if let json = dictionary[key.mappedKey] {
                guard let initializable = key.valueType as? JsonInitializable.Type else {
                    throw ConvertibleError.NotJsonInitializable(type: key.valueType)
                }
                let value = try initializable.initializeWithJson(json, options: options)
                if let value = value as? OptionalProtocol {
                    try setValue(value.any, forKey: key)
                } else {
                    try setValue(value, forKey: key)
                }
            }
        }
    }
    
    func checkDictionaryForMissingRequiredKeys(dictionary: [NSString:JsonValue]) throws {
        var missingRequiredKeys = [String]()
        for key in requiredKeys(self) {
            if !dictionary.keys.contains(key.mappedKey) {
                missingRequiredKeys.append(key.mappedKey)
            }
        }
        guard missingRequiredKeys.count == 0 else {
            throw ConvertibleError.MissingRequiredJsonKeys(keys: missingRequiredKeys)
        }
    }
    
    func checkForNilRequiredKeys() throws {
        var nilRequiredKeys = [String]()
        for key in requiredKeys(self) {
            if key.summary == "nil" {
                nilRequiredKeys.append(key.key)
            }
        }
        guard nilRequiredKeys.count == 0 else {
            throw ConvertibleError.NilRequiredKeys(keys: nilRequiredKeys)
        }
    }
    
}

protocol OptionalProtocol {
    var any: Any? { get }
}

extension Optional : OptionalProtocol {
    
    var any: Any? {
        switch self {
        case .Some(let any): return any as Any
        default: break
        }
        return nil
    }
    
}