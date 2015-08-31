//
//  Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/25/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class ClassConvertible_ : XCTestCase {
    
    func testDataConvertible() {
        do {
            let result = try Person.initializeWithData(Data.personData)
            let data = try result.serializeToData()
            XCTAssert(Data.personData == data)
        } catch {
            XCTFail()
        }
    }
    
}
