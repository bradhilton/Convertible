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
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        let json = try JsonValue.initializeWithData(data, options: options)
        if let this = self as? JsonInitializable.Type,
            let new = try this.initializeWithJson(json, options: options) as? Self {
                return new
        } else {
            throw ConvertibleError.NotJsonInitializable(type: self)
        }
    }
    
}

public protocol DataModelSerializable : DataSerializable {}

extension DataModelSerializable {
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        if let this = self as? JsonSerializable {
            return try this.serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
        } else {
            throw ConvertibleError.NotJsonSerializable(type: self.dynamicType)
        }
    }
    
}