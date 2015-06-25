//
//  NSImage+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import AppKit

extension NSImage : DataConvertible {
    
    public class func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self {
        return try imageFromData(data, options: options)
    }
    
    class func imageFromData<T>(data: NSData, options: [ConvertibleOption]) throws -> T {
        guard let image = NSImage(data: data) as? T else {
            throw ConvertibleError.CannotCreateImageFromData()
        }
        return image
    }
    
    public func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData {
        guard let tiff = TIFFRepresentation, let bitmap = NSBitmapImageRep(data: tiff) else {
            throw ConvertibleError.CannotCreateDataFromImage()
        }
        switch ConvertibleOptions.ImageEncoding.Option(options) {
        case .JPEG(quality: let quality):
            guard let data = bitmap.representationUsingType(NSBitmapImageFileType.NSJPEGFileType, properties: [NSImageCompressionFactor: NSNumber(float: Float(quality))]) else {
                throw ConvertibleError.CannotCreateDataFromImage()
            }
            return data
        case .PNG:
            guard let data = bitmap.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: [:]) else {
                throw ConvertibleError.CannotCreateDataFromImage()
            }
            return data
        }
    }
    
}

extension NSImage : JsonConvertible {

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