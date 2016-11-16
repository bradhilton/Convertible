//
//  Double+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Double : JsonConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Double {
        switch json {
        case .string(let string): return string.doubleValue
        case .number(let number): return number.doubleValue
        default: throw ConvertibleError.cannotCreateType(type: self, fromJson: json)
        }
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.number(NSNumber(value: self as Double))
    }
    
}
