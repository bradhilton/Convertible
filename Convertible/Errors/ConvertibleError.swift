//
//  ConvertibleError.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public enum ConvertibleError : ErrorType, CustomStringConvertible {
    
    case UnknownError
    case MissingRequiredJsonKeys(keys: [String])
    case NilRequiredKeys(keys: [String])
    case UnsettableKey(key: String)
    case NotJsonInitializable(type: Any.Type)
    case NotJsonSerializable(type: Any.Type)
    case CannotCreateType(type: Any.Type, fromJson: JsonValue)
    case ObjectNotJsonValue(object: AnyObject)
    case NotStringType(type: Any.Type)
    case NotObjectType(type: Any.Type)
    case NotPropertyType(type: Any.Type)
    case CannotCreateUrlFromString(string: String)
    case CannotCreateDateFromString(string: String)
    case CannotCreateImageFromData()
    case CannotCreateDataFromImage()
    case CannotCreateDataFromBase64String()
    
    public var description: String {
        return "Convertible Error: \(errorDescription)"
    }
    
    var errorDescription: String {
        switch self {
        case .UnknownError: return "An unknown error occurred"
        case .MissingRequiredJsonKeys(keys: let keys): return "Missing required json keys: \(keys)"
        case .NilRequiredKeys(keys: let keys): return "Failed to set required keys: \(keys)"
        case .UnsettableKey(key: let key): return "Cannot set key: " + key
        case .NotJsonInitializable(type: let type): return "\(type) does not implement JsonInitializable"
        case .NotJsonSerializable(type: let type): return "\(type) does not implement JsonSerializable"
        case .NotStringType(type: let type): return "\(type) is not a String type"
        case .NotObjectType(type: let type): return "\(type) does not conform to AnyObject"
        case .NotPropertyType(type: let type): return "\(type) does not conform to SwiftKVC.Property"
        case .CannotCreateType(type: let type, fromJson: let json): return "Cannot create \(type) from \(json)"
        case .ObjectNotJsonValue(object: let object): return "\(object.dynamicType) is not a JSON value"
        case .CannotCreateUrlFromString(string: let string): return "Could not create URL from \(string)"
        case .CannotCreateDateFromString(string: let string): return "Could not create date from \(string)"
        case .CannotCreateImageFromData(): return "Could not create image from data"
        case .CannotCreateDataFromImage(): return "Could not create data from image"
        case .CannotCreateDataFromBase64String(): return "Could not create data from Base64 string"
        }
    }

}