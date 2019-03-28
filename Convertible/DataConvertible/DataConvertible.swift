//
//  DataConvertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/8/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public typealias DataConvertible = DataInitializable & DataSerializable

public protocol DataInitializable {
    
    static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self

}

public protocol DataSerializable {
    
    func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data

}

extension DataInitializable {
    
    public static func initializeWithData(_ data: Data) throws -> Self {
        return try initializeWithData(data, options: [])
    }
    
}

extension DataSerializable {
    
    public func serializeToData() throws -> Data {
        return try serializeToDataWithOptions([])
    }

}

extension DataInitializable where Self : Decodable {
    
    public static func initializeWithData(_ data: Data, options: [ConvertibleOption]) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = ConvertibleOptions.JSONKeyDecodingStrategy.Option(options).strategy
        decoder.dateDecodingStrategy = .formatted(ConvertibleOptions.DateFormatter.Option(options).formatter)
        return try decoder.decode(self, from: data)
    }
    
}

extension DataSerializable where Self : Encodable {
    
    public func serializeToDataWithOptions(_ options: [ConvertibleOption]) throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = ConvertibleOptions.JSONKeyEncodingStrategy.Option(options).strategy
        encoder.dateEncodingStrategy = .formatted(ConvertibleOptions.DateFormatter.Option(options).formatter)
        return try encoder.encode(self)
    }
    
}
