//
//  File.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/1/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

//extension NSObject : JsonConvertible {
//    
//    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
//        return try objectFromJson(json)
//    }
//    
//    static func objectFromJson<T>(json: JsonValue) throws -> T {
//        guard let object = json.object as? T else {
//            throw ConvertibleError.UnknownError
//        }
//        return object
//    }
//    
//    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
//        return try JsonValue(object: self)
//    }
//
//}