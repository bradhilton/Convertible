//
//  NSData+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/28/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Data : DataConvertible {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Data {
        return data
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return self
    }
    
}
