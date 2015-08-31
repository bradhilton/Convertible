//
//  Array+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/15/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Array : DataModelConvertible {}

extension Array : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Array {
        switch json {
        case .Array(let array): return try resultFromArray(array, options: options)
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    static func resultFromArray(array: [JsonValue], options: [ConvertibleOption]) throws -> Array {
        let error = ConvertibleError.NotJsonInitializable(type: Element.self)
        guard let generic = Element.self as? JsonInitializable.Type else { throw error }
        var result = Array<Element>()
        for json in array {
            guard let element = try generic.initializeWithJson(json, options: options) as? Element else { throw error }
            result.append(element)
        }
        return result
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        var array = [JsonValue]()
        for element in self {
            guard let element = element as? JsonSerializable else {
                throw ConvertibleError.NotJsonSerializable(type: Element.self)
            }
            array.append(try element.serializeToJsonWithOptions(options))
        }
        return JsonValue.Array(array)
    }
    
}