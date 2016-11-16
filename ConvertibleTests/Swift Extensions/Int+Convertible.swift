//
//  Int+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class Int_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let int = NSNumber(value: 101 as Int)
            let result = try Int.initializeWithJson(try JsonValue(object: int))
            let object = try result.serializeToJson().object as! NSNumber
            XCTAssert(int == object)
        } catch {
            XCTFail()
        }
    }
    
}
