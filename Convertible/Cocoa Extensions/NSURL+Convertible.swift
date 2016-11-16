//
//  NSURL+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/18/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension URL : JsonConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> URL {
        return try urlFromJson(json, options: options)
    }
    
    static func urlFromJson<T>(_ json: JsonValue, options: [ConvertibleOption]) throws -> T {
        let string = try String.initializeWithJson(json, options: options)
        guard let url = URL(string: string), let result = url as? T else {
            throw ConvertibleError.cannotCreateUrlFromString(string: string)
        }
        return result
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.string(self.absoluteString as NSString)
    }
    
}
