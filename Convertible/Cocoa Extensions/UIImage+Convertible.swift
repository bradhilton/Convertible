//
//  UIImage+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import UIKit

extension UIImage : DataConvertible {
    
    public class func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try imageFromData(data, options: options)
    }
    
    class func imageFromData<T>(data: NSData, options: [ConvertibleOption]) throws -> T {
        guard let image = UIImage(data: data) as? T else {
            throw ConvertibleError.CannotCreateImageFromData()
        }
        return image
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        switch ConvertibleOptions.ImageEncoding.Option(options) {
        case .JPEG(quality: let quality):
            guard let data = UIImageJPEGRepresentation(self, quality) else {
                throw ConvertibleError.CannotCreateDataFromImage()
            }
            return data
        case .PNG:
            guard let data = UIImagePNGRepresentation(self) else {
                throw ConvertibleError.CannotCreateDataFromImage()
            }
            return data
        }
    }
    
}

extension UIImage : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        switch json {
        case .String(let string): return try imageFromString(string as String, options: options)
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    class func imageFromString<T>(string: String, options: [ConvertibleOption]) throws -> T {
        guard let data = NSData(base64EncodedString: string, options: NSDataBase64DecodingOptions()) else {
            throw ConvertibleError.CannotCreateDataFromBase64String()
        }
        guard let image = try initializeWithData(data, options: options) as? T else {
            throw ConvertibleError.CannotCreateImageFromData()
        }
        return image
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        let data = try self.serializeToDataWithOptions(options)
        return JsonValue.String(data.base64EncodedStringWithOptions(ConvertibleOptions.Base64EncodingOptions.Option(options).options))
    }
    
}