//
//  NSNull+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/11/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSNull : DataConvertible {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        return self.init()
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return Data()
    }
    
}
