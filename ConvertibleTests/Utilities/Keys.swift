//
//  Keys.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/24/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import XCTest
@testable import Convertible

extension CollectionType where Self.Generator.Element == Key {
    
    func containsKey(key: String) -> Bool {
        return self.map { $0.key }.contains(key)
    }
    
}

class Keys: XCTestCase {
    
    let requiredKeysPerson = RequiredKeysPerson()
    let optionalKeysPerson = OptionalKeysPerson()
    let allKeysPerson = AllKeysPerson()
    
    func testUnderscoreFromCamelCase() {
        XCTAssert(underscoreFromCamelCase("helloWorld") == "hello_world")
    }
    
    func testAllKeys() {
        for key in ["firstName", "lastName", "isPublic"] {
            XCTAssert(allKeys(requiredKeysPerson).containsKey(key))
        }
        for key in ["super", "keyMapping", "ignoredKeys", "requiredKeys", "optionalKeys", "age"] {
            XCTAssert(!allKeys(requiredKeysPerson).containsKey(key))
        }
    }
    
    func testRequiredKeys() {
        for key in requiredKeysPerson.requiredKeys {
            XCTAssert(requiredKeys(requiredKeysPerson).containsKey(key))
        }
        XCTAssert(requiredKeys(requiredKeysPerson).count == requiredKeysPerson.requiredKeys.count)
        for key in ["firstName", "lastName"] {
            XCTAssert(requiredKeys(optionalKeysPerson).containsKey(key))
        }
        XCTAssert(requiredKeys(optionalKeysPerson).count == 2)
    }
    
    func testKeyMapping() {
        for key in allKeys(requiredKeysPerson) {
            if key.key == "firstName" {
                XCTAssert(key.mappedKey == "first_name")
            }
            if key.key == "isPublic" {
                XCTAssert(key.mappedKey == "public")
            }
        }
    }
    
    func testSetKey() {
        for key in allKeys(requiredKeysPerson) {
            if key.key == "firstName" {
                XCTAssert(key.setKey == "setFirstName:")
            }
            if key.key == "isPublic" {
                XCTAssert(key.setKey == "setIsPublic:")
            }
        }
    }
    
}

