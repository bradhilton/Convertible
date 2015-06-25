//
//  Set+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class Set_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let set: NSSet = ["Hello", "World"]
            let array: NSArray = set.allObjects
            let result = try Set<String>.initializeWithJson(JsonValue(object: array))
            let object = NSSet(array: try result.serializeToJson().object as! [AnyObject])
            XCTAssert(set == object)
        } catch {
            XCTFail()
        }
    }
    
}
