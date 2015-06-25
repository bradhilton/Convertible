//
//  NSDictionary+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/11/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSDictionary : DataConvertible {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try initializeWithJson(JsonValue.initializeWithData(data, options: options), options: options)
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
}

extension NSDictionary : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try dictionaryWithJson(json)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func dictionaryWithJson<T>(json: JsonValue) throws -> T {
        switch json {
        case .Dictionary(_): if let dictionary = json.object as? T { return dictionary }
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.UnknownError
    }
    
}