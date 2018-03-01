//
//  JsonArrayConvertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 8/18/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

public protocol JsonArrayConvertible : JsonConvertible, Sequence {
    init<S : Sequence>(_ sequence: S) where S.Iterator.Element == Self.Iterator.Element
}

extension JsonArrayConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return self.init(try Array<Element>.initializeWithJson(json, options: options))
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return try Array(self).serializeToJsonWithOptions(options)
    }
    
}
