//
//  Models.swift
//  Convertible
//
//  Created by Bradley Hilton on 6/25/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Convertible

typealias Number = NSNumber

class Person : Convertible, UnderscoreToCamelCase {
    
    var id: Number?
    var firstName: String?
    var lastName: String?
    var `public`: Number?
    var bestFriend: Person?
    
}

class RequiredKeysPerson : NSObject, UnderscoreToCamelCase, CustomKeys, IgnoredKeys, RequiredKeys, OptionalKeys {
    var firstName: String? = "Brad"
    var lastName: String? = "Hilton"
    var isPublic = false
    var age = 26
    var keyMapping = ["isPublic":"public"]
    var ignoredKeys = ["age"]
    var requiredKeys = ["firstName", "lastName"]
    var optionalKeys = [String]()
}

class OptionalKeysPerson : OptionalKeys {
    var firstName = "Brad"
    var lastName = "Hilton"
    var isPublic = false
    var optionalKeys = ["isPublic"]
}

class AllKeysPerson {
    var firstName = "Brad"
    var lastName = "Hilton"
    var isPublic = false
}