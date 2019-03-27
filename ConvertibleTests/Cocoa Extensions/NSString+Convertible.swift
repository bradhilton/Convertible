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
    
}
