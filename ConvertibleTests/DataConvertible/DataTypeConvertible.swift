//
//  DataTypeConvertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class DataTypeConvertible: XCTestCase {
    
    func testDataConvertible() {
        do {
            let result = try [NSDictionary].initializeWithData(Data.arrayData)
            let data = try result.serializeToData()
            XCTAssert(Data.arrayData == data)
        } catch {
            XCTFail()
        }
    }
    
}
