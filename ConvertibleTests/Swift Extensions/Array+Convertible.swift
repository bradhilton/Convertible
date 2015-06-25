//
//  Array+Convertible.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/15/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class Array_Convertible : XCTestCase {
    
    func testJsonConvertible() {
        do {
            let array: NSArray = ["Hello", "World"]
            let result = try Array<String>.initializeWithJson(JsonValue(object: array))
            let object = try result.serializeToJson().object as! NSArray
            XCTAssert(array == object)
        } catch {
            XCTFail()
        }
    }
    
}