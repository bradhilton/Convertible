//
//  Updatable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

import Reflection

public protocol Updatable : JsonUpdatable, KeyMapping {}

extension Updatable {
    
    public mutating func updateWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws {
        switch json {
        case .dictionary(let dictionary): return try updateWithDictionary(dictionary, options: options)
        default: throw ConvertibleError.cannotCreateType(type: type(of: self), fromJson: json)
        }
    }
    
    mutating func updateWithDictionary(_ dictionary: [NSString: JsonValue], options: [ConvertibleOption]) throws {
        for field in try properties(type(of: self)) {
            guard let mappedKey = type(of: self).mappedKeyForPropertyKey(field.reducedKey) else { continue }
            guard let jsonInitializable = field.type as? JsonInitializable.Type else {
                throw ConvertibleError.notJsonInitializable(type: field.type)
            }
            if let value = dictionary[mappedKey as NSString] {
                try set(jsonInitializable.initializeWithJson(value, options: options),
                             key: field.key,
                             for: &self)
            }
        }
    }
    
}
