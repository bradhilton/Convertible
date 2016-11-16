//
//  NSNumber+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSNumber : JsonConvertible {
    
    public class func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try numberWithJson(json, formatter: ConvertibleOptions.NumberFormatter.Option(options).formatter)
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func numberWithJson<T>(_ json: JsonValue, formatter: NumberFormatter) throws -> T {
        switch json {
        case .string(let string): if let number = formatter.number(from: string as String) as? T { return number }
        case .number(let number): if let number = number as? T { return number }
        default: throw ConvertibleError.cannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.unknownError
    }
    
}

