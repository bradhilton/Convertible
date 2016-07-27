//
//  Updatable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

import Allegro

public protocol Updatable : JsonUpdatable, KeyMapping {}

extension Updatable {
    
    public mutating func updateWithJson(json: JsonValue, options: [ConvertibleOption]) throws {
        switch json {
        case .Dictionary(let dictionary): return try updateWithDictionary(dictionary, options: options)
        default: throw ConvertibleError.CannotCreateType(type: self.dynamicType, fromJson: json)
        }
    }
    
    mutating func updateWithDictionary(dictionary: [NSString: JsonValue], options: [ConvertibleOption]) throws {
        for field in try fieldsForType(self.dynamicType) {
            guard let mappedKey = self.dynamicType.mappedKeyForPropertyKey(field.reducedName) else { continue }
            guard let jsonInitializable = field.type as? JsonInitializable.Type else {
                throw ConvertibleError.NotJsonInitializable(type: field.type)
            }
            if let value = dictionary[mappedKey] {
                try setValue(jsonInitializable.initializeWithJson(value, options: options),
                             forKey: field.name,
                             ofInstance: &self)
            }
        }
    }
    
}
