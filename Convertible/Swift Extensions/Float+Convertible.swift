//
//  Float+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Float : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Float {
        switch json {
        case .String(let string): return string.floatValue
        case .Number(let number): return number.floatValue
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.Number(NSNumber(float: self))
    }
    
}