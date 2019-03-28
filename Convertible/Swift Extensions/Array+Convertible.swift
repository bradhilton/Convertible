//
//  Array+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/15/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension Array : DataInitializable where Element : Decodable {}

extension Array : DataSerializable where Element : Encodable {}
