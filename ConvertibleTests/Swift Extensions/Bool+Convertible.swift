//
//  Bool+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class Bool_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let bool = NSNumber(value: true as Bool)
            let result = try Bool.initializeWithJson(try JsonValue(object: bool))
            let object = try result.serializeToJson().object as! NSNumber
            XCTAssert(bool == object)
        } catch {
            XCTFail()
        }
    }
    
}
