//
//  Optional+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/13/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Optional : DataConvertible {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Optional {
        guard let initializable = Wrapped.self as? DataInitializable.Type else { throw ConvertibleError.notDataInitializable(type: Wrapped.self) }
        let value = try initializable.initializeWithData(data, options: options)
        guard let wrapped = value as? Wrapped else { throw ConvertibleError.unknownError }
        return Optional(wrapped)
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        guard let value = self else { throw ConvertibleError.cannotCreateDataFromNilOptional() }
        guard let serializable = value as? DataSerializable else { throw ConvertibleError.notDataSerializable(type: Wrapped.self) }
        return try serializable.serializeToDataWithOptions(options)
    }
    
}

extension Optional : JsonConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Optional {
        switch json {
        case .null(_): return nil
        default:
            if let type = Wrapped.self as? JsonInitializable.Type, let value = try type.initializeWithJson(json, options: options) as? Wrapped {
                return self.init(value)
            } else {
                throw ConvertibleError.cannotCreateType(type: self, fromJson: json)
            }
        }
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        let error = ConvertibleError.notJsonSerializable(type: Wrapped.self)
        guard Wrapped.self is JsonSerializable.Type else { throw error }
        if let object = self {
            guard let serializable = object as? JsonSerializable else { throw error }
            return try serializable.serializeToJsonWithOptions(options)
        } else {
            return JsonValue.null(NSNull())
        }
    }
    
}
