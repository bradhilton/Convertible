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
    
    static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self

}

public protocol DataSerializable {
    
    func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data

}

extension DataInitializable {
    
    public static func initializeWithData(_ data: Data) throws -> Self {
        return try initializeWithData(data, options: [])
    }
    
}

extension DataSerializable {
    
    public func serializeToData() throws -> Data {
        return try serializeToDataWithOptions([])
    }

}
