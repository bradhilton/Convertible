//
//  UIImage+Convertible.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
import Convertible

class UIImage_Convertible: XCTestCase {
    
    func testDataConvertible() {
        do {
            let options: [ConvertibleOption] = [ConvertibleOptions.ImageEncoding.JPEG(quality: 0.82)]
            let image = try UIImage.initializeWithData(Data.jpegData, options: options)
            let data = try image.serializeToDataWithOptions(options)
            XCTAssert(abs(Data.jpegData.length - data.length) < 1000)
        } catch {
            XCTFail()
        }
    }
    
    func testJsonConvertible() {
        do {
            let base64: NSString = Data.pngData.base64EncodedStringWithOptions([])
            let image = try UIImage.initializeWithJson(try JsonValue(object: base64))
            let object = try image.serializeToJson().object as! NSString
            XCTAssert(abs(base64.length - object.length) < 20000)
        } catch {
            XCTFail()
        }
    }
    
}
