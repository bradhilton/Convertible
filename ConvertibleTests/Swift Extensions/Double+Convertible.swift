//
//  Double+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class Double_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let double = NSNumber(value: 12.5 as Double)
            let result = try Double.initializeWithJson(try JsonValue(object: double))
            let object = try result.serializeToJson().object as! NSNumber
            XCTAssert(double == object)
        } catch {
            XCTFail()
        }
    }
    
}
