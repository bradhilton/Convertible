//
//  Convertible2.swift
//  Convertible
//
//  Created by Bradley Hilton on 9/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation
import Reflection

extension Property {
    var reducedKey: String {
        return key.components(separatedBy: ".")[0]
    }
}

extension Property.Description {
    var reducedKey: String {
        return key.components(separatedBy: ".")[0]
    }
}

public protocol Convertible : Initializable, Serializable {}
