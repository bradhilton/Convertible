//
//  ConvertibleOption.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

public protocol ConvertibleOption {}

protocol _ConvertibleOption : ConvertibleOption {
    static var Default: Self { get set }
}

extension _ConvertibleOption {
    
    static func Option(_ options: [ConvertibleOption]?) -> Self {
        if let options = options {
            for option in options {
                if let option = option as? Self {
                    return option
                }
            }
        }
        return Self.Default
    }
    
}
