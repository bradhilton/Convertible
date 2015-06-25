//
//  Int+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Int : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Int {
        switch json {
        case .String(let string): return string.integerValue
        case .Number(let number): return number.integerValue
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.Number(NSNumber(integer: self))
    }
    
}
