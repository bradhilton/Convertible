//
//  Bool+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Bool : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Bool {
        switch json {
        case .String(let string): return string.boolValue
        case .Number(let number): return number.boolValue
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.Number(NSNumber(bool: self))
    }
    
}