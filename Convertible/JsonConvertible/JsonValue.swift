//
//  JsonValue.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/9/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public typealias JsonDictionaryKey = NSString

public enum JsonValue {
    
    case string(NSString)
    case number(NSNumber)
    case array([JsonValue])
    case dictionary([JsonDictionaryKey : JsonValue])
    case null(NSNull)
    
    public init(object: Any) throws {
        switch object {
        case let object as JsonDictionaryKey: self = JsonValue.string(object)
        case let object as NSNumber: self = JsonValue.number(object)
        case let object as NSArray: self = JsonValue.array(try convertNSArray(object))
        case let object as NSDictionary: self = JsonValue.dictionary(try convertNSDictionary(object))
        case let object as NSNull: self = JsonValue.null(object)
        default: throw ConvertibleError.objectNotJsonValue(object: object)
        }
    }
    
    public var object: AnyObject {
        switch self {
        case .string(let string): return string
        case .number(let number): return number
        case .array(let array): return convertValueArray(array)
        case .dictionary(let dictionary): return convertValueDictionary(dictionary)
        case .null(let null): return null
        }
    }
    
}

extension JsonValue : DataConvertible {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> JsonValue {
        return try JsonValue(object: try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments))
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self.object, options: JSONSerialization.WritingOptions())
    }
    
}

extension JsonValue : JsonConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> JsonValue {
        return json
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return self
    }
    
}

private func convertNSArray(_ array: NSArray) throws -> [JsonValue] {
    var result = [JsonValue]()
    for object in array {
        result.append(try JsonValue(object: object as AnyObject))
    }
    return result
}

private func convertValueArray(_ array: [JsonValue]) -> NSArray {
    let result = NSMutableArray()
    for value in array {
        result.add(value.object)
    }
    return result
}

private func convertNSDictionary(_ dictionary: NSDictionary) throws -> [JsonDictionaryKey : JsonValue] {
    var result = [JsonDictionaryKey : JsonValue]()
    for (key, value) in dictionary {
        if let key = key as? JsonDictionaryKeySerializable {
            try result[key.serializeToJsonDictionaryKeyWithOptions([])] = JsonValue(object: value)
        } else {
            throw ConvertibleError.notJsonDictionaryKeySerializable(type: type(of: key))
        }
    }
    return result
}

private func convertValueDictionary(_ dictionary: [JsonDictionaryKey : JsonValue]) -> NSDictionary {
    let result = NSMutableDictionary()
    for (key, value) in dictionary {
        result.setObject(value.object, forKey: key)
    }
    return result
}
