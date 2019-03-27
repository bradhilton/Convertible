//
//  String+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension String : DataConvertible {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> String {
        return try NSString.initializeWithData(data, options: options) as String
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return try (self as NSString).serializeToDataWithOptions(options)
    }
    
}
