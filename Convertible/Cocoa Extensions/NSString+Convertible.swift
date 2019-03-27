//
//  NSString+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSString : DataConvertible {
    
    public class func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        return try stringWithData(data, encoding: ConvertibleOptions.StringEncoding.Option(options).encoding)
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        if let data = data(using: ConvertibleOptions.StringEncoding.Option(options).encoding.rawValue) {
            return data
        } else {
            throw ConvertibleError.unknownError
        }
    }
    
    class func stringWithData<T>(_ data: Data, encoding: String.Encoding) throws -> T {
        if let string = NSString(data: data, encoding: encoding.rawValue) as? T {
            return string
        } else {
            throw ConvertibleError.unknownError
        }
    }
    
}
