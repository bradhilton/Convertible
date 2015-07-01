//
//  JsonValue.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/9/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public enum JsonValue {
    
    case String(NSString)
    case Number(NSNumber)
    case Array([JsonValue])
    case Dictionary([NSString : JsonValue])
    case Null(NSNull)
    
    public init(object: AnyObject) throws {
        switch object {
        case let object as NSString: self = JsonValue.String(object)
        case let object as NSNumber: self = JsonValue.Number(object)
        case let object as NSArray: self = JsonValue.Array(try convertNSArray(object))
        case let object as NSDictionary: self = JsonValue.Dictionary(try convertNSDictionary(object))
        case let object as NSNull: self = JsonValue.Null(object)
        default: throw ConvertibleError.ObjectNotJsonValue(object: object)
        }
    }
    
    public var object: AnyObject {
        switch self {
        case .String(let string): return string
        case .Number(let number): return number
        case .Array(let array): return convertValueArray(array)
        case .Dictionary(let dictionary): return convertValueDictionary(dictionary)
        case .Null(let null): return null
        }
    }
    
}

extension JsonValue : DataConvertible {
    
    public static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments))
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        return try NSJSONSerialization.dataWithJSONObject(self.object, options: NSJSONWritingOptions())
    }
    
}

extension JsonValue : JsonConvertible {
    
    public static func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> JsonValue {
        return json
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return self
    }
    
}

private func convertNSArray(array: NSArray) throws -> [JsonValue] {
    var result = [JsonValue]()
    for object in array {
        result.append(try JsonValue(object: object))
    }
    return result
}

private func convertValueArray(array: [JsonValue]) -> NSArray {
    let result = NSMutableArray()
    for value in array {
        result.addObject(value.object)
    }
    return result
}

private func convertNSDictionary(dictionary: NSDictionary) throws -> [NSString : JsonValue] {
    var result = [NSString : JsonValue]()
    for (key, value) in dictionary {
        if let key = key as? NSString {
            result[key] = try JsonValue(object: value)
        } else {
            throw ConvertibleError.NotStringType(type: key.dynamicType)
        }
    }
    return result
}

private func convertValueDictionary(dictionary: [NSString : JsonValue]) -> NSDictionary {
    let result = NSMutableDictionary()
    for (key, value) in dictionary {
        result.setObject(value.object, forKey: key)
    }
    return result
}
