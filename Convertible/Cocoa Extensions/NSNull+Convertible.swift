//
//  NSNull+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/11/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSNull : DataConvertible {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return self.init()
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return NSData()
    }
    
}

extension NSNull : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try nullWithJson(json)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func nullWithJson<T>(json: JsonValue) throws -> T {
        switch json {
        case .Null(let null): if let null = null as? T { return null }
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.UnknownError
    }
    
}
