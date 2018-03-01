//
//  String+Utilities.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/12/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return String(self[index(startIndex, offsetBy: r.lowerBound)..<index(startIndex, offsetBy: r.upperBound)])
    }
    
}
