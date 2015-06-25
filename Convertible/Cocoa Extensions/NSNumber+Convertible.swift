//
//  NSNumber+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

//extension NSNumber : DataConvertible {
//    
//    public class func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
//        let string = try String.initializeWithData(data, options: options)
//        return try numberFromString(string, formatter: ConvertibleOptions.NumberFormatter.Option(options).formatter)
//    }
//    
//    class func numberFromString<T>(string: String, formatter: NSNumberFormatter) throws -> T {
//        if let number = formatter.numberFromString(string) as? T {
//            return number
//        } else {
//            throw ConvertibleError.UnknownError
//        }
//    }
//    
//    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
//        if let string = ConvertibleOptions.NumberFormatter.Option(options).formatter.stringFromNumber(self) {
//            return try string.serializeToDataWithOptions(options)
//        } else {
//            throw ConvertibleError.UnknownError
//        }
//    }
//    
//}

extension NSNumber : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try numberWithJson(json, formatter: ConvertibleOptions.NumberFormatter.Option(options).formatter)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func numberWithJson<T>(json: JsonValue, formatter: NSNumberFormatter) throws -> T {
        switch json {
        case .String(let string): if let number = formatter.numberFromString(string as String) as? T { return number }
        case .Number(let number): if let number = number as? T { return number }
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.UnknownError
    }
    
}

