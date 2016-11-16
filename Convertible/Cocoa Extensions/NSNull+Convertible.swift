//
//  NSNull+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/11/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSNull : DataConvertible {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        return self.init()
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return Data()
    }
    
}

extension NSNull : JsonConvertible {
    
    public class func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try nullWithJson(json)
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func nullWithJson<T>(_ json: JsonValue) throws -> T {
        switch json {
        case .null(let null): if let null = null as? T { return null }
        default: throw ConvertibleError.cannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.unknownError
    }
    
}
