//
//  Float+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Float : JsonConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Float {
        switch json {
        case .string(let string): return string.floatValue
        case .number(let number): return number.floatValue
        default: throw ConvertibleError.cannotCreateType(type: self, fromJson: json)
        }
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.number(NSNumber(value: self as Float))
    }
    
}
