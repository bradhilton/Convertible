//
//  NSImage+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible


class NSImage_Convertible: XCTestCase {

    func testDataConvertible() {
        do {
            let options: [ConvertibleOption] = [ConvertibleOptions.ImageEncoding.JPEG(quality: 0.71)]
            let image = try NSImage.initializeWithData(Data.jpegData, options: options)
            let data = try image.serializeToDataWithOptions(options)
            XCTAssert(abs(Data.jpegData.length - data.length) < 1000)
        } catch {
            XCTFail()
        }
    }
    
    func testJsonConvertible() {
        do {
            let base64: NSString = Data.pngData.base64EncodedStringWithOptions([])
            let image = try NSImage.initializeWithJson(try JsonValue(object: base64))
            let object = try image.serializeToJson().object as! NSString
            XCTAssert(abs(base64.length - object.length) < 40000)
        } catch {
            XCTFail()
        }
    }

    
}
