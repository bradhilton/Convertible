//
//  ConvertibleOptions.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/11/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation
import CoreGraphics

public struct ConvertibleOptions {
    
    /// Use this option to customize how data is decoded from Base64
    public struct Base64DecodingOptions: _ConvertibleOption {
        public let options: NSDataBase64DecodingOptions
        public static var Default = Base64DecodingOptions(options: NSDataBase64DecodingOptions())
        public init(options: NSDataBase64DecodingOptions) {
            self.options = options
        }
    }
    
    /// Use this option to customize how data is encoded to Base64
    public struct Base64EncodingOptions: _ConvertibleOption {
        public let options: NSDataBase64EncodingOptions
        public static var Default = Base64EncodingOptions(options: NSDataBase64EncodingOptions())
        public init(options: NSDataBase64EncodingOptions) {
            self.options = options
        }
    }
    
    /// Use this option to specify the expected data type for objects and collections
    public enum DataType: _ConvertibleOption {
        case JSON
        case XML /// currently unsupported
        case Foundation /// currently unsupported
        public static var Default = DataType.JSON
    }
    
    /// Use this option to include a custom NSDateFormatter
    /// Default date formatter assumes a ISO 8601 date string
    public struct DateFormatter: _ConvertibleOption {
        public let formatter: NSDateFormatter
        public static var Default: DateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return DateFormatter(formatter: formatter)
        }()
        public init(formatter: NSDateFormatter) {
            self.formatter = formatter
        }
    }
    
    /// Use this option to specify how an image should be encoded
    public enum ImageEncoding: _ConvertibleOption {
        case JPEG(quality: CGFloat)
        case PNG
        public static var Default = ImageEncoding.PNG
    }
    
    /// Use this option to include a custom NSNumberFormatter
    public struct NumberFormatter: _ConvertibleOption {
        public let formatter: NSNumberFormatter
        public static var Default: NumberFormatter = {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            return NumberFormatter(formatter: formatter)
        }()
        public init(formatter: NSNumberFormatter) {
            self.formatter = formatter
        }
    }
    
    /// Use to specify custom NSStringEncoding; default is NSUTF8StringEncoding
    public struct StringEncoding: _ConvertibleOption {
        public let encoding: NSStringEncoding
        public static var Default = StringEncoding(encoding: NSUTF8StringEncoding)
        public init(encoding: NSStringEncoding) {
            self.encoding = encoding
        }
    }

}
