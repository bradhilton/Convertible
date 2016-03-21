//
//  ValueConvertible_.swift
//  Convertible
//
//  Created by Bradley Hilton on 7/21/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class StructConvertible_ : XCTestCase {
    
    func testDataConvertible() {
        do { 
            let result = try PersonValue.initializeWithData(Data.personData)
            let data = try result.serializeToData()
            XCTAssert(Data.personData == data)
        } catch {
            XCTFail(String(error))
        }
    }
    
}
