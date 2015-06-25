//
//  NSURL+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/18/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSURL : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try urlFromJson(json, options: options)
    }
    
    class func urlFromJson<T>(json: JsonValue, options: [ConvertibleOption]) throws -> T {
        let string = try String.initializeWithJson(json, options: options)
        guard let url = NSURL(string: string), let result = url as? T else {
            throw ConvertibleError.CannotCreateUrlFromString(string: string)
        }
        return result
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.String(self.absoluteString)
    }
    
}
