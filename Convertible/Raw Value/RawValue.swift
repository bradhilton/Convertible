//
//  JsonRawValue.swift
//  Convertible
//
//  Created by Bradley Hilton on 11/7/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol RawValueConvertible : RawValueInitializable, RawValueSerializable, DataRawValueConvertible {}

public protocol RawValueInitializable : DataRawValueInitializable {}

public protocol RawValueSerializable : DataRawValueSerializable {}

public protocol DataRawValueConvertible : DataRawValueInitializable, DataRawValueSerializable {}

public protocol DataRawValueInitializable : DataInitializable, RawRepresentable {}

extension DataRawValueInitializable where RawValue : DataInitializable {

    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        guard let value = self.init(rawValue: try RawValue.initializeWithData(data, options: options)) else {
            throw ConvertibleError.cannotCreateTypeFromData(type: self)
        }
        return value
    }
    
}

public protocol DataRawValueSerializable : DataSerializable, RawRepresentable {}

extension DataRawValueSerializable where RawValue : DataSerializable {
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return try self.rawValue.serializeToDataWithOptions(options)
    }
    
}
