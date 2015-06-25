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
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
    
    var length: Int {
        return self.characters.count
    }
    
}