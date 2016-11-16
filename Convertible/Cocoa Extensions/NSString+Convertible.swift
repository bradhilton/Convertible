//
//  NSString+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSString : DataConvertible {
    
    public class func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        return try stringWithData(data, encoding: ConvertibleOptions.StringEncoding.Option(options).encoding)
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        if let data = data(using: ConvertibleOptions.StringEncoding.Option(options).encoding.rawValue) {
            return data
        } else {
            throw ConvertibleError.unknownError
        }
    }
    
    class func stringWithData<T>(_ data: Data, encoding: String.Encoding) throws -> T {
        if let string = NSString(data: data, encoding: encoding.rawValue) as? T {
            return string
        } else {
            throw ConvertibleError.unknownError
        }
    }
    
}

extension NSString : JsonConvertible {
    
    public class func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try stringWithJson(json)
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func stringWithJson<T>(_ json: JsonValue) throws -> T {
        switch json {
        case .string(let string): if let string = string as? T { return string }
        case .number(let number): if let string = number.stringValue as? T { return string }
        default: throw ConvertibleError.cannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.unknownError
    }
    
}

extension NSString : JsonDictionaryKeyConvertible {
    
    public class func initializeWithJsonDictionaryKey(_ key: JsonDictionaryKey, options: [ConvertibleOption]) throws -> Self {
        func cast<T>(_ key: JsonDictionaryKey) -> T {
            return key as! T
        }
        return cast(key)
    }
    
    public func serializeToJsonDictionaryKeyWithOptions(_ options: [ConvertibleOption]) throws -> JsonDictionaryKey {
        return self
    }
    
}

