//
//  NSDictionary+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class NSDictionary_Convertible: XCTestCase {
    
    func testDataConvertible() {
        do {
            let result = try NSDictionary.initializeWithData(Data.dictionaryData)
            let data = try result.serializeToData()
            XCTAssert(Data.dictionaryData == data)
        } catch {
            XCTFail()
        }
    }
    
    func testJsonConvertible() {
        do {
            let dictionary: NSDictionary = ["Hello" : "World"]
            let result = try NSDictionary.initializeWithJson(JsonValue(object: dictionary))
            let object = try result.serializeToJson().object as! NSDictionary
            XCTAssert(dictionary == object)
        } catch {
            XCTFail()
        }
    }
    
}
