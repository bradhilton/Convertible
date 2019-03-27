//
//  ConvertibleError.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public enum ConvertibleError : Error, CustomStringConvertible {
    
    case unknownError
    case missingRequiredJsonKeys(keys: [String])
    case nilRequiredKeys(keys: [String])
    case unsettableKey(key: String)
    case notDataInitializable(type: Any.Type)
    case notDataSerializable(type: Any.Type)
    case notJsonInitializable(type: Any.Type)
    case notJsonSerializable(type: Any.Type)
    case cannotCreateTypeFromData(type: Any.Type)
    case objectNotJsonValue(object: Any)
    case notJsonDictionaryKeyInitializable(type: Any.Type)
    case notJsonDictionaryKeySerializable(type: Any.Type)
    case notObjectType(type: Any.Type)
    case notPropertyType(type: Any.Type)
    case cannotCreateUrlFromString(string: String)
    case cannotCreateDateFromString(string: String)
    case cannotCreateImageFromData
    case cannotCreateDataFromImage
    case cannotCreateDataFromBase64String
    case cannotCreateDataFromNilOptional
    
    public var description: String {
        return "Convertible Error: \(errorDescription)"
    }
    
    var errorDescription: String {
        switch self {
        case .unknownError: return "An unknown error occurred"
        case .missingRequiredJsonKeys(keys: let keys): return "Missing required json keys: \(keys)"
        case .nilRequiredKeys(keys: let keys): return "Failed to set required keys: \(keys)"
        case .unsettableKey(key: let key): return "Cannot set key: " + key
        case .notDataInitializable(type: let type): return "\(type) does not implement DataInitializable"
        case .notDataSerializable(type: let type): return "\(type) does not implement DataSerializable"
        case .notJsonInitializable(type: let type): return "\(type) does not implement JsonInitializable"
        case .notJsonSerializable(type: let type): return "\(type) does not implement JsonSerializable"
        case .notJsonDictionaryKeyInitializable(type: let type): return "\(type) does not implement JsonDictionaryKeyInitializable"
        case .notJsonDictionaryKeySerializable(type: let type): return "\(type) does not implement JsonDictionaryKeySerializable"
        case .notObjectType(type: let type): return "\(type) does not conform to AnyObject"
        case .notPropertyType(type: let type): return "\(type) does not conform to Allegro.Property"
        case .cannotCreateTypeFromData(type: let type): return "Cannot create \(type) from binary data"
        case .objectNotJsonValue(object: let object): return "\(type(of: object)) is not a JSON value"
        case .cannotCreateUrlFromString(string: let string): return "Could not create URL from \(string)"
        case .cannotCreateDateFromString(string: let string): return "Could not create date from \(string)"
        case .cannotCreateImageFromData: return "Could not create image from data"
        case .cannotCreateDataFromImage: return "Could not create data from image"
        case .cannotCreateDataFromBase64String: return "Could not create data from Base64 string"
        case .cannotCreateDataFromNilOptional: return "Cannot create data from nil optional"
        }
    }

}
