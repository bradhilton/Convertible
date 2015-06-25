//
//  NSArray+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/11/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSArray : DataConvertible {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try initializeWithJson(JsonValue.initializeWithData(data, options: options), options: options)
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
}

extension NSArray : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try arrayWithJson(json)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func arrayWithJson<T>(json: JsonValue) throws -> T {
        switch json {
        case .Array(_): if let array = json.object as? T { return array }
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.UnknownError
    }
    
}
