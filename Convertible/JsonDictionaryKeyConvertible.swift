//
//  DictionaryKeyConvertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/28/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

public protocol JsonDictionaryKeyInitializable {
    
    static func initializeWithJsonDictionaryKey(key: JsonDictionaryKey, options: [ConvertibleOption]) throws -> Self
    
}

public protocol JsonDictionaryKeySerializable {
    
    func serializeToJsonDictionaryKeyWithOptions(options: [ConvertibleOption]) throws -> JsonDictionaryKey
    
}

public protocol JsonDictionaryKeyConvertible : JsonDictionaryKeyInitializable, JsonDictionaryKeySerializable {}
