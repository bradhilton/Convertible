//
//  JsonArrayConvertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 8/18/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

public protocol JsonArrayConvertible : JsonConvertible, SequenceType {
    associatedtype Element
    init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S)
}

extension JsonArrayConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return self.init(try Array<Element>.initializeWithJson(json, options: options))
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try Array(self).serializeToJsonWithOptions(options)
    }
    
}
