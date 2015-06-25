//
//  NSNumber+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class NSNumber_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let number = NSNumber(double: 12.5)
            let result = try NSNumber.initializeWithJson(try JsonValue(object: number))
            let object = try result.serializeToJson().object as! NSNumber
            XCTAssert(number == object)
        } catch {
            XCTFail()
        }
    }
    
}
