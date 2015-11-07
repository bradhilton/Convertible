//
//  JsonRawValue.swift
//  Convertible
//
//  Created by Bradley Hilton on 11/7/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol RawValueConvertible : RawValueInitializable, RawValueSerializable, DataRawValueConvertible, JsonRawValueConvertible {}

public protocol RawValueInitializable : DataRawValueInitializable, JsonRawValueInitializable {}

public protocol RawValueSerializable : DataRawValueSerializable, JsonRawValueSerializable {}

public protocol DataRawValueConvertible : DataRawValueInitializable, DataRawValueSerializable {}

public protocol DataRawValueInitializable : DataInitializable, RawRepresentable {}

extension DataRawValueInitializable where RawValue : DataInitializable {

    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        guard let value = self.init(rawValue: try RawValue.initializeWithData(data, options: options)) else {
            throw ConvertibleError.CannotCreateTypeFromData(type: self)
        }
        return value
    }
    
}

public protocol DataRawValueSerializable : DataSerializable, RawRepresentable {}

extension DataRawValueSerializable where RawValue : DataSerializable {
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try self.rawValue.serializeToDataWithOptions(options)
    }
    
}

public protocol JsonRawValueConvertible : JsonRawValueInitializable, JsonRawValueSerializable {}

public protocol JsonRawValueInitializable : JsonInitializable, RawRepresentable {}

extension JsonRawValueInitializable where RawValue : JsonInitializable {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        guard let value = self.init(rawValue: try RawValue.initializeWithJson(json, options: options)) else {
            throw ConvertibleError.CannotCreateType(type: self, fromJson: json) // Create new error
        }
        return value
    }
    
}

public protocol JsonRawValueSerializable : JsonSerializable, RawRepresentable {}

extension JsonRawValueSerializable where RawValue : JsonSerializable {
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return try self.rawValue.serializeToJsonWithOptions(options)
    }
    
}