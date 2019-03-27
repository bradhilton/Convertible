//
//  Array+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/15/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Array : DataInitializable where Element : Decodable {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Array<Element> {
        let decoder = JSONDecoder()
        if Element.self is UnderscoreToCamelCase.Type {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        }
        decoder.dateDecodingStrategy = .formatted(ConvertibleOptions.DateFormatter.Option(options).formatter)
        return try decoder.decode(self, from: data)
    }
    
    
}

extension Array : DataSerializable where Element : Encodable {
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        let encoder = JSONEncoder()
        if Element.self is UnderscoreToCamelCase.Type {
            encoder.keyEncodingStrategy = .convertToSnakeCase
        }
        encoder.dateEncodingStrategy = .formatted(ConvertibleOptions.DateFormatter.Option(options).formatter)
        return try encoder.encode(self)
    }
    
}
