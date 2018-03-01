//
//  NSDate+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class NSDate_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let dateString = "2008-03-01T13:00:00Z"
            let json = JsonValue.string(dateString as NSString)
            let date = try Date.initializeWithJson(json)
            let newJson = try date.serializeToJson()
            XCTAssert(dateString == newJson.object as! String)
        } catch {
            XCTFail()
        }
    }
    
}
