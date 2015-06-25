//
//  Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public class Convertible : NSObject, DataConvertible, JsonConvertible, _ConvertibleType {
    
    public required override init() {}
    
    public class func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try initializeWithJson(JsonValue.initializeWithData(data, options: options), options: options)
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        let object = self.init()
        if let convertible = object as? _ConvertibleType {
            try convertible.loadJson(json, options: options)
        }
        return object
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try self.jsonValueWithOptions(options)
    }
    
}