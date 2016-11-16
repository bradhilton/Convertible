//
//  NSURL+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class NSURL_Convertible: XCTestCase {
    
    func testJsonConvertible() {
        do {
            let url: NSString = "https://www.google.com"
            let result = try URL.initializeWithJson(try JsonValue(object: url))
            let object = try result.serializeToJson().object as! NSString
            XCTAssert(url == object)
        } catch {
            XCTFail()
        }
    }
    
}
