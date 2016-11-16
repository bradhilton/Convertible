//
//  NSDate+Covertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/20/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Date : JsonConvertible {
    
    public static func initializeWithJson(_ json: JsonValue, options: [ConvertibleOption]) throws -> Date {
        switch json {
        case .string(let string): return try dateFromString(string as String, options: options)
        default: throw ConvertibleError.cannotCreateType(type: self, fromJson: json)
        }
    }
    
    static func dateFromString<T>(_ string: String, options: [ConvertibleOption]) throws -> T {
        let formatter = ConvertibleOptions.DateFormatter.Option(options).formatter
        var object: AnyObject?
        try formatter.getObjectValue(&object, for: string, range: nil)
        guard let date = object as? T else { throw ConvertibleError.cannotCreateDateFromString(string: string) }
        return date
    }
    
    public func serializeToJsonWithOptions(_ options: [ConvertibleOption]) throws -> JsonValue {
        return JsonValue.string(ConvertibleOptions.DateFormatter.Option(options).formatter.string(from: self) as NSString)
    }
    
}
