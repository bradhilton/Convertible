//
//  Initializable.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/27/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

public protocol Initializable : DataInitializable, Decodable {}

extension Initializable {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        let decoder = JSONDecoder()
        if self is UnderscoreToCamelCase.Type {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        }
        decoder.dateDecodingStrategy = .formatted(ConvertibleOptions.DateFormatter.Option(options).formatter)
        return try decoder.decode(self, from: data)
    }
    
}
