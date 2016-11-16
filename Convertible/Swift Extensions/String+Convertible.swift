//
//  String+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension String : DataConvertible {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> String {
        return try NSString.initializeWithData(data, options: options) as String
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return try (self as NSString).serializeToDataWithOptions(options)
    }
    
}

extension String : JsonConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> String {
        return try NSString.initializeWithJson(json, options: options) as String
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return try (self as NSString).serializeToJsonWithOptions(options)
    }
    
}

extension String : JsonDictionaryKeyConvertible {
    
    public static func initializeWithJsonDictionaryKey(_ key: JsonDictionaryKey, options: [ConvertibleOption]) throws -> String {
        return key as String
    }
    
    public func serializeToJsonDictionaryKeyWithOptions(_ options: [ConvertibleOption]) throws -> JsonDictionaryKey {
        return self as JsonDictionaryKey
    }
    
}
