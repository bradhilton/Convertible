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
        public let options: NSData.Base64DecodingOptions
        public static var Default = Base64DecodingOptions(options: NSData.Base64DecodingOptions())
        public init(options: NSData.Base64DecodingOptions) {
            self.options = options
        }
    }
    
    /// Use this option to customize how data is encoded to Base64
    public struct Base64EncodingOptions: _ConvertibleOption {
        public let options: NSData.Base64EncodingOptions
        public static var Default = Base64EncodingOptions(options: NSData.Base64EncodingOptions())
        public init(options: NSData.Base64EncodingOptions) {
            self.options = options
        }
    }
    
    /// Use this option to include a custom NSDateFormatter
    /// Default date formatter assumes a ISO 8601 date string
    public struct DateFormatter: _ConvertibleOption {
        public let formatter: Foundation.DateFormatter
        public static var Default: DateFormatter = {
            let formatter = Foundation.DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return DateFormatter(formatter: formatter)
        }()
        public init(formatter: Foundation.DateFormatter) {
            self.formatter = formatter
        }
    }
    
    /// Use this option to specify how an image should be encoded
    public enum ImageEncoding: _ConvertibleOption {
        case jpeg(quality: CGFloat)
        case png
        public static var Default = ImageEncoding.png
    }
    
    /// Use this option to include a custom NSNumberFormatter
    public struct NumberFormatter: _ConvertibleOption {
        public let formatter: Foundation.NumberFormatter
        public static var Default: NumberFormatter = {
            let formatter = Foundation.NumberFormatter()
            formatter.numberStyle = Foundation.NumberFormatter.Style.decimal
            return NumberFormatter(formatter: formatter)
        }()
        public init(formatter: Foundation.NumberFormatter) {
            self.formatter = formatter
        }
    }
    
    /// Use to specify custom NSStringEncoding; default is NSUTF8StringEncoding
    public struct StringEncoding: _ConvertibleOption {
        public let encoding: String.Encoding
        public static var Default = StringEncoding(encoding: String.Encoding.utf8)
        public init(encoding: String.Encoding) {
            self.encoding = encoding
        }
    }

}
