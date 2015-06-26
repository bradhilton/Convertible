//
//  NSNumber+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSNumber : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try numberWithJson(json, formatter: ConvertibleOptions.NumberFormatter.Option(options).formatter)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func numberWithJson<T>(json: JsonValue, formatter: NSNumberFormatter) throws -> T {
        switch json {
        case .String(let string): if let number = formatter.numberFromString(string as String) as? T { return number }
        case .Number(let number): if let number = number as? T { return number }
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.UnknownError
    }
    
}

