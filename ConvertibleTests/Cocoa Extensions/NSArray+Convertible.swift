//
//  NSArray+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class NSArray_Convertible: XCTestCase {
    
    func testDataConvertible() {
        do {
            let result = try NSArray.initializeWithData(Data.arrayData)
            let data = try result.serializeToData()
            XCTAssert(Data.arrayData == data)
        } catch {
            XCTFail()
        }
    }
    
    func testJsonConvertible() {
        do {
            let array: NSArray = ["Hello", "World"]
            let result = try NSArray.initializeWithJson(JsonValue(object: array))
            let object = try result.serializeToJson().object as! NSArray
            XCTAssert(array == object)
        } catch {
            XCTFail()
        }
    }
    
}
