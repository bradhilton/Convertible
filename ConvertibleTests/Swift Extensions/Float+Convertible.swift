//
//  Float+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class Float_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let float = NSNumber(value: 1.70 as Float)
            let result = try Float.initializeWithJson(try JsonValue(object: float))
            let object = try result.serializeToJson().object as! NSNumber
            XCTAssert(float == object)
        } catch {
            XCTFail()
        }
    }
    
}
