//
//  String+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension String : DataConvertible {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> String {
        return try NSString.initializeWithData(data, options: options) as String
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try (self as NSString).serializeToDataWithOptions(options)
    }
    
}

extension String : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> String {
        return try NSString.initializeWithJson(json, options: options) as String
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try (self as NSString).serializeToJsonWithOptions(options)
    }
    
}