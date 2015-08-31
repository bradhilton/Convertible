//
//  Set+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

extension Set : DataModelConvertible {}

extension Set : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Set {
        return self.init(try Array<Element>.initializeWithJson(json, options: options))
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try Array(self).serializeToJsonWithOptions(options)
    }
    
}