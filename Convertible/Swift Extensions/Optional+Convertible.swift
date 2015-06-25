//
//  Optional+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/13/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Optional : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Optional {
        switch json {
        case .Null(_): return nil
        default:
            if let type = T.self as? JsonInitializable.Type, let value = try type.initializeWithJson(json, options: options) as? T {
                return self.init(value)
            } else {
                throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
            }
        }
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        let error = ConvertibleError.NotJsonSerializable(type: T.self)
        guard T.self is JsonSerializable.Type else { throw error }
        if let object = self {
            guard let serializable = object as? JsonSerializable else { throw error }
            return try serializable.serializeToJsonWithOptions(options)
        } else {
            return JsonValue.Null(NSNull())
        }
    }
    
}
