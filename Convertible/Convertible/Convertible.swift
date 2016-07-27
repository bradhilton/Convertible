//
//  Convertible2.swift
//  Convertible
//
//  Created by Bradley Hilton on 9/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation
import Allegro

extension Field {
    var reducedName: String {
        return name.componentsSeparatedByString(".")[0]
    }
}

extension Property {
    var reducedKey: String {
        return key.componentsSeparatedByString(".")[0]
    }
}

public protocol Convertible : Initializable, Serializable {}
