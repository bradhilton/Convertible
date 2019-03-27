//
//  Serializable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

public protocol Serializable : DataSerializable, Codable {}

extension Serializable {
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        let encoder = JSONEncoder()
        if self is UnderscoreToCamelCase {
            encoder.keyEncodingStrategy = .convertToSnakeCase
        }
        encoder.dateEncodingStrategy = .formatted(ConvertibleOptions.DateFormatter.Option(options).formatter)
        return try encoder.encode(self)
    }
    
}
