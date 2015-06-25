//
//  String+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class String_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let string: NSString = "Hello, world"
            let result = try String.initializeWithJson(try JsonValue(object: string))
            let object = try result.serializeToJson().object as! NSString
            XCTAssert(string == object)
        } catch {
            XCTFail()
        }
    }
    
}
