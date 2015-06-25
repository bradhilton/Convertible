//
//  _ConvertibleType.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

protocol _ConvertibleType : NSObjectProtocol {}

extension _ConvertibleType {
    
    func loadJson(json: JsonValue, options: [ConvertibleOption]) throws {
        switch json {
        case .Dictionary(let dictionary): return try loadDictionary(dictionary, options: options)
        default:
            throw ConvertibleError.CannotCreateType(type: self.dynamicType, fromJson: json)
        }
    }
    
    func loadDictionary(dictionary: [NSString:JsonValue], options: [ConvertibleOption]) throws {
        try checkDictionaryForMissingRequiredKeys(dictionary)
        for key in allKeys(self) {
            if let json = dictionary[key.mappedKey] {
                guard let initializable = key.valueType as? JsonInitializable.Type else {
                    throw ConvertibleError.NotJsonInitializable(type: key.valueType)
                }
                try setValue(try initializable.initializeWithJson(json, options: options), forKey: key)
            }
        }
        try checkForNilRequiredKeys()
    }
    
    func setValue(value: JsonInitializable, forKey key: Key) throws {
        if let object = anyObject(value) {
            guard let target = self as? NSObject else {
                throw ConvertibleError.UnknownError
            }
            guard respondsToSelector(NSSelectorFromString(key.setKey)) else {
                throw ConvertibleError.UnsettableKey(key: key.key)
            }
            target.setValue(object, forKey: key.key)
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
    
    func jsonValueWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
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

func anyObject(any: Any) -> AnyObject? {
    if let object = any as? AnyObject {
        return object
    } else if let optional = any as? OptionalProtocol, let object = optional.object {
        return object
    } else {
        return nil
    }
}

protocol OptionalProtocol {
    var object: AnyObject? { get }
}

extension Optional : OptionalProtocol {
    
    var object: AnyObject? {
        switch self {
        case .Some(let object): return object as? AnyObject
        default: break
        }
        return nil
    }
    
}