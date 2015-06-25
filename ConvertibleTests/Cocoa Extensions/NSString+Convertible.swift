//
//  NSString+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class NSString_Convertible: XCTestCase {
    
    func testDataConvertible() {
        do {
            let result = try NSString.initializeWithData(Data.arrayData)
            let data = try result.serializeToData()
            XCTAssert(Data.arrayData == data)
        } catch {
            XCTFail()
        }
    }
    
    func testJsonConvertible() {
        do {
            let string: NSString = "Hello, world"
            let result = try NSString.initializeWithJson(try JsonValue(object: string))
            let object = try result.serializeToJson().object as! NSString
            XCTAssert(string == object)
        } catch {
            XCTFail()
        }
    }
    
}
