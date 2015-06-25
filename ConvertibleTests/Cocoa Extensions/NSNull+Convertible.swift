//
//  NSNull+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class NSNull_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let null = NSNull()
            let result = try NSNull.initializeWithJson(try JsonValue(object: null))
            let object = try result.serializeToJson().object as! NSNull
            XCTAssert(null == object)
        } catch {
            XCTFail()
        }
    }

}
