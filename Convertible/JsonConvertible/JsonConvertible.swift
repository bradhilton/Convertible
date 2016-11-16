//
//  JsonConvertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/8/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol JsonConvertible : JsonInitializable, JsonSerializable {}

public protocol JsonInitializable {
    
    static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Self
    
}

public protocol JsonSerializable {
    
    func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue
    
}

extension JsonInitializable {
    
    public static func initializeWithJson(_ json: JsonValue) throws -> Self {
        return try initializeWithJson(json, options: [])
    }
    
}

extension JsonSerializable {
    
    public func serializeToJson() throws -> JsonValue {
        return try serializeToJsonWithOptions([])
    }
    
}
