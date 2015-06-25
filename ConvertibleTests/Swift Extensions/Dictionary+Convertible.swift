//
//  Dictionary+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class Dictionary_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let dictionary: NSDictionary = ["Hello" : "World"]
            let result = try Dictionary<String, String>.initializeWithJson(JsonValue(object: dictionary))
            let object = try result.serializeToJson().object as! NSDictionary
            XCTAssert(dictionary == object)
        } catch {
            XCTFail()
        }
    }
    
}
