//
//  NSSet+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSSet : DataConvertible {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try initializeWithJson(JsonValue.initializeWithData(data, options: options), options: options)
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
}

extension NSSet : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try setFromJson(json, options: options)
    }
    
    class func setFromJson<T>(json: JsonValue, options: [ConvertibleOption]) throws -> T {
        guard let set = NSSet(array: try NSArray.initializeWithJson(json, options: options) as [AnyObject]) as? T else {
            throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
        return set
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: allObjects as NSArray)
    }
    
}