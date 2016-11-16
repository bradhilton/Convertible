//
//  Data.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

let bundle = Bundle(identifier: "com.skyvive.ConvertibleTests")!

func dataForResource(_ resource: String, ofType type: String) -> Foundation.Data {
    return (try! Foundation.Data(contentsOf: URL(fileURLWithPath: bundle.path(forResource: resource, ofType: type)!)))
}

struct Data {
    static let arrayData = dataForResource("Array", ofType: "json")
    static let dictionaryData = dataForResource("Dictionary", ofType: "json")
    static let jpegData = dataForResource("JPEG", ofType: "jpg")
    static let personData = dataForResource("Person", ofType: "json")
    static let pngData = dataForResource("PNG", ofType: "png")
}

