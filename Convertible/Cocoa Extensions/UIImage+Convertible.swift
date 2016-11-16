//
//  UIImage+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import UIKit

extension UIImage : DataConvertible {
    
    public class func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        return try imageFromData(data, options: options)
    }
    
    class func imageFromData<T>(_ data: Data, options: [ConvertibleOption]) throws -> T {
        guard let image = UIImage(data: data) as? T else {
            throw ConvertibleError.cannotCreateImageFromData()
        }
        return image
    }
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        switch ConvertibleOptions.ImageEncoding.Option(options) {
        case .jpeg(quality: let quality):
            guard let data = UIImageJPEGRepresentation(self, quality) else {
                throw ConvertibleError.cannotCreateDataFromImage()
            }
            return data
        case .png:
            guard let data = UIImagePNGRepresentation(self) else {
                throw ConvertibleError.cannotCreateDataFromImage()
            }
            return data
        }
    }
    
}

extension UIImage : JsonConvertible {
    
    public class func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        switch json {
        case .string(let string): return try imageFromString(string as String, options: options)
        default: throw ConvertibleError.cannotCreateType(type: self, fromJson: json)
        }
    }
    
    class func imageFromString<T>(_ string: String, options: [ConvertibleOption]) throws -> T {
        guard let data = Data(base64Encoded: string, options: ConvertibleOptions.Base64DecodingOptions.Option(options).options) else {
            throw ConvertibleError.cannotCreateDataFromBase64String()
        }
        guard let image = try initializeWithData(data, options: options) as? T else {
            throw ConvertibleError.cannotCreateImageFromData()
        }
        return image
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        let data = try self.serializeToDataWithOptions(options)
        return JsonValue.string(data.base64EncodedString(options: ConvertibleOptions.Base64EncodingOptions.Option(options).options) as NSString)
    }
    
}
