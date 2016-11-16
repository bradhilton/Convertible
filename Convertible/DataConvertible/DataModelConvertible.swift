//
//  DataTypeConvertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/22/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol DataModelConvertible : DataConvertible, DataModelInitializable, DataModelSerializable {}

public protocol DataModelInitializable : DataInitializable {}

extension DataModelInitializable {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        let json = try JsonValue.initializeWithData(data, options: options)
        if let this = self as? JsonInitializable.Type,
            let new = try this.initializeWithJson(json, options: options) as? Self {
                return new
        } else {
            throw ConvertibleError.notJsonInitializable(type: self)
        }
    }
    
}

public protocol DataModelSerializable : DataSerializable {}

extension DataModelSerializable {
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        if let this = self as? JsonSerializable {
            return try this.serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
        } else {
            throw ConvertibleError.notJsonSerializable(type: type(of: self))
        }
    }
    
}
