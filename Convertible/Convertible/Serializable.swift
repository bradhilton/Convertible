//
//  Serializable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

import Reflection

public protocol Serializable : DataSerializable, JsonSerializable, KeyMapping {}

extension Serializable {
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        var dictionary = [JsonDictionaryKey : JsonValue]()
        for property in try properties(self) {
            guard let mappedKey = type(of: self).mappedKeyForPropertyKey(property.reducedKey) else { continue }
            guard let serializable = property.value as? JsonSerializable else {
                throw ConvertibleError.notJsonSerializable(type: type(of: property.value))
            }
            let json = try serializable.serializeToJsonWithOptions(options)
            switch json {
            case .null(_): break
            default: dictionary[mappedKey as NSString] = json
            }
        }
        return JsonValue.dictionary(dictionary)
    }
    
}
