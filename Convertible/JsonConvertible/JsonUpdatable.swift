//
//  JsonUpdatable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

public protocol JsonUpdatable {
    mutating func updateWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws
}

extension JsonUpdatable {
    
    public mutating func updateWithJson(_ json: JsonValue) throws {
        try updateWithJson(json, options: [])
    }
    
}
