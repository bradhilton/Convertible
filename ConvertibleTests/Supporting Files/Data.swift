//
//  Data.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

let bundle = NSBundle(identifier: "com.skyvive.ConvertibleTests")!

func dataForResource(resource: String, ofType type: String) -> NSData {
    return NSData(contentsOfFile: bundle.pathForResource(resource, ofType: type)!)!
}

struct Data {
    static let arrayData = dataForResource("Array", ofType: "json")
    static let dictionaryData = dataForResource("Dictionary", ofType: "json")
    static let jpegData = dataForResource("JPEG", ofType: "jpg")
    static let personData = dataForResource("Person", ofType: "json")
    static let pngData = dataForResource("PNG", ofType: "png")
}

