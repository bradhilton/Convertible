//
//  DataConvertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/8/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol DataConvertible : DataInitializable, DataSerializable {}

public protocol DataInitializable {
    
    static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self

}

public protocol DataSerializable {
    
    func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData

}

extension DataInitializable {
    
    public static func initializeWithData(data: NSData) throws -> Self {
        return try initializeWithData(data, options: [])
    }
    
}

extension DataSerializable {
    
    public func serializeToData() throws -> NSData {
        return try serializeToDataWithOptions([])
    }

}
