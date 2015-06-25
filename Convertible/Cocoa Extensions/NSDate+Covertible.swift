//
//  NSDate+Covertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSDate : JsonConvertible {
    
    public class func initializeWithJson(json: JsonValue, options: [ConvertibleOption]) throws -> Self {
        switch json {
        case .String(let string): return try dateFromString(string as String, options: options)
        default: throw ConvertibleError.CannotCreateType(type: self, fromJson: json)
        }
    }
    
    class func dateFromString<T>(string: String, options: [ConvertibleOption]) throws -> T {
        guard let date = ConvertibleOptions.DateFormatter.Option(options).formatter.dateFromString(string) as? T else {
            throw ConvertibleError.CannotCreateDateFromString(string: string)
        }
        return date
    }
    
    public func serializeToJsonWithOptions(options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.String(ConvertibleOptions.DateFormatter.Option(options).formatter.stringFromDate(self))
    }
    
}