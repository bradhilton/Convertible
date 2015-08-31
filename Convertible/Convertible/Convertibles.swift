//
//  Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation
import SwiftKVC

public class ClassConvertible : NSObject, DataConvertible, JsonModelConvertible {
    
    public required override init() {}
    
    public class func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try initializeWithJson(JsonValue.initializeWithData(data, options: options), options: options)
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try serializeToJsonWithOptions(options).serializeToDataWithOptions(options)
    }
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        let object = self.init()
        var convertible = object as ClassConvertible
        try convertible.loadJson(json, options: options)
        return object
    }
    
    public func setValue(value: Any?, forKey key: Convertible.Key) throws {
        guard respondsToSelector(NSSelectorFromString(key.setKey)) else {
            throw ConvertibleError.UnsettableKey(key: key.key)
        }
        if value == nil {
            setValue(nil, forKey: key.key)
        } else if let object = value! as? AnyObject {
            setValue(object, forKey: key.key)
        } else {
            throw ConvertibleError.NotObjectType(type: value!.dynamicType)
        }
    }
    
}

public protocol StructConvertible : SwiftKVC.Model, DataModelConvertible, JsonModelConvertible {}

extension StructConvertible {
    
    public mutating func setValue(value: Any?, forKey key: Convertible.Key) throws {
        if value == nil {
            self[key.key] = nil
        } else if let value = value! as? Property {
            self[key.key] = value
        } else {
            throw ConvertibleError.NotPropertyType(type: value!.dynamicType)
        }
    }
    
}

public protocol ModelSerializable : DataModelSerializable, JsonModelSerializable {}

