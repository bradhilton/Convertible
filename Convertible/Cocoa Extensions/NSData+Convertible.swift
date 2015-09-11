//
//  NSData+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/28/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSData : DataConvertible {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return self.init(data: data)
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return self
    }
    
}

extension NSData : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try dataFromJson(json, options: options)
    }
    
    class func dataFromJson<T : NSData>(json: JsonValue, options: [ConvertibleOption]) throws -> T {
        guard let data = try json.serializeToDataWithOptions(options) as? T else {
            throw ConvertibleError.CannotCreateType(type: T.self, fromJson: json)
        }
        return data
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.String(try NSString.initializeWithData(self, options: options))
    }
    
}
