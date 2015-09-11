//
//  Convertible2.swift
//  Convertible
//
//  Created by Bradley Hilton on 9/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation
import SwiftKVC

public protocol Initializable : DataInitializable, JsonInitializable, Model, Keys {
    init()
}

public protocol Serializable : DataSerializable, JsonSerializable, Model, Keys {}

public protocol Convertible : Initializable, Serializable {}

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
        var object = self.init()
        try object.checkDictionaryForMissingRequiredKeys(dictionary)
        try object.loadDictionary(dictionary, options: options)
        try object.checkForNilRequiredKeys()
        return object
    }
    
    mutating func loadDictionary(dictionary: [NSString: JsonValue], options: [ConvertibleOption]) throws {
        for key in allKeys {
            if let jsonValue = dictionary[key.mappedKey] {
                guard let jsonInitializable = key.type as? JsonInitializable.Type else {
                    throw ConvertibleError.NotJsonInitializable(type: key.type)
                }
                let value = try jsonInitializable.initializeWithJson(jsonValue, options: options)
                if let value = value as? OptionalProtocol {
                    try setAnyValue(value.any, forKey: key.key)
                } else {
                    try setAnyValue(value, forKey: key.key)
                }
            }
        }
    }
    
    mutating func setAnyValue(value: Any?, forKey key: String) throws {
        if value == nil {
            try setValue(nil, forKey: key)
        } else if let value = value! as? Property {
            try setValue(value, forKey: key)
        } else {
            throw SwiftKVC.Error.TypeDoesNotConformToProperty(type: value!.dynamicType)
        }
    }
    
    func checkDictionaryForMissingRequiredKeys(dictionary: [NSString : JsonValue]) throws {
        var missingRequiredKeys = [String]()
        for key in requiredKeys {
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
        for key in requiredKeys {
            if String(key.value) == "nil" {
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

extension Serializable {
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        var dictionary = [NSString : JsonValue]()
        for key in self.allKeys {
            guard let serializable = key.value as? JsonSerializable else {
                throw ConvertibleError.NotJsonSerializable(type: key.type)
            }
            dictionary[key.mappedKey] = try serializable.serializeToJsonWithOptions(options)
        }
        return JsonValue.Dictionary(dictionary)
    }
    
}




