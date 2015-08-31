//
//  NSData+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/28/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSData : DataConvertible {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return self.init(data: data)
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return self
    }
    
}
