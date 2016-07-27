//
//  Serializable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

import Allegro

public protocol Serializable : DataSerializable, JsonSerializable, KeyMapping {}

extension Serializable {
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        var dictionary = [NSString : JsonValue]()
        for property in try propertiesForInstance(self) {
            guard let mappedKey = self.dynamicType.mappedKeyForPropertyKey(property.reducedKey) else { continue }
            guard let serializable = property.value as? JsonSerializable else {
                throw ConvertibleError.NotJsonSerializable(type: property.value.dynamicType)
            }
            let json = try serializable.serializeToJsonWithOptions(options)
            switch json {
            case .Null(_): break
            default: dictionary[mappedKey] = json
            }
        }
        return JsonValue.Dictionary(dictionary)
    }
    
}
