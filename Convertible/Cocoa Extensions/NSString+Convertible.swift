//
//  NSString+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSString : DataConvertible {
    
    public class func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try stringWithData(data, encoding: ConvertibleOptions.StringEncoding.Option(options).encoding)
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        if let data = dataUsingEncoding(ConvertibleOptions.StringEncoding.Option(options).encoding) {
            return data
        } else {
            throw ConvertibleError.UnknownError
        }
    }
    
    class func stringWithData<T>(data: NSData, encoding: NSStringEncoding) throws -> T {
        if let string = NSString(data: data, encoding: encoding) as? T {
            return string
        } else {
            throw ConvertibleError.UnknownError
        }
    }
    
}

extension NSString : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        return try stringWithJson(json)
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: self)
    }
    
    class func stringWithJson<T>(json: JsonValue) throws -> T {
        switch json {
        case .String(let string): if let string = string as? T { return string }
        case .Number(let number): if let string = number.stringValue as? T { return string }
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
        throw ConvertibleError.UnknownError
    }
    
}