//
//  Double+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Double : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Double {
        switch json {
        case .String(let string): return string.doubleValue
        case .Number(let number): return number.doubleValue
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.Number(NSNumber(double: self))
    }
    
}