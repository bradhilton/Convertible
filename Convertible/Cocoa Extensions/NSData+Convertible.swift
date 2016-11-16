//
//  NSData+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/28/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Data : DataConvertible {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Data {
        return data
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return self
    }
    
}

extension Data : JsonConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Data {
        return try dataFromJson(json, options: options)
    }
    
    static func dataFromJson<T>(_ json: JsonValue, options: [ConvertibleOption]) throws -> T {
        guard let data = try json.serializeToDataWithOptions(options) as? T else {
            throw ConvertibleError.cannotCreateType(type: T.self, fromJson: json)
        }
        return data
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.string(try NSString.initializeWithData(self, options: options))
    }
    
}
