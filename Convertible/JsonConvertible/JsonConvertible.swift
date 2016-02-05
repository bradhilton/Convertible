//
//  JsonConvertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/8/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation
import Allegro

public protocol JsonConvertible : JsonInitializable, JsonSerializable {}

public protocol JsonInitializable : Allegro.Property {
    
    static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self
    
}

public protocol JsonSerializable : Allegro.Property {
    
    func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue
    
}

extension JsonInitializable {
    
    public static func initializeWithJson(json: JsonValue) throws -> Self {
        return try initializeWithJson(json, options: [])
    }
    
}

extension JsonSerializable {
    
    public func serializeToJson() throws -> JsonValue {
        return try serializeToJsonWithOptions([])
    }
    
}
