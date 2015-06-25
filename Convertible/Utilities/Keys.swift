//
//  Properties.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/9/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol UnderscoreToCamelCase {}

public protocol CustomKeys {
    
    var keyMapping: [String : String] { get }
    
}

public protocol IgnoredKeys {
    
    var ignoredKeys: [String] { get }
    
}

public protocol RequiredKeys {
    
    var requiredKeys: [String] { get }
    
}

public protocol OptionalKeys {
    
    var optionalKeys: [String] { get }
    
}

let ignoredKeys = ["super", "keyMapping", "ignoredKeys", "requiredKeys", "optionalKeys"]

struct Key {
    
    let object: Any
    let key: String
    let value: Any
    let valueType: Any.Type
    let summary: String
    
}

extension Key {
    
    var mappedKey: String {
        var mappedKey = key
        if let object = object as? CustomKeys, let customKey = object.keyMapping[key] {
            mappedKey = customKey
        } else if object is UnderscoreToCamelCase {
            mappedKey = underscoreFromCamelCase(key)
        }
        return mappedKey
    }
    
    var setKey: String {
        var setKey = "set"
        if key.length > 0 {
            setKey += (key[0] as String).uppercaseString
        }
        if key.length > 1 {
            setKey += (key[1..<key.length] as String)
        }
        return setKey + ":"
    }
    
}

func requiredKeys(object: Any) -> [Key] {
    if let object = object as? RequiredKeys {
        return allKeys(object).filter { object.requiredKeys.contains($0.key) }
    } else if let object = object as? OptionalKeys {
        return allKeys(object).filter { !object.optionalKeys.contains($0.key) }
    } else {
        return [Key]()
    }
}

func allKeys(object: Any) -> [Key] {
    var keys = [Key]()
    for (key, mirror) in properties(object) {
        if ignoredKeys.contains(key) {
            continue
        } else if let object = object as? IgnoredKeys where object.ignoredKeys.contains(key) {
            continue
        } else {
            keys.append(Key(object: object, key: key, value: mirror.value, valueType: mirror.valueType, summary: mirror.summary))
        }
    }
    return keys
}

func underscoreFromCamelCase(camelCase: String) -> String {
    let options = NSStringEnumerationOptions.ByComposedCharacterSequences
    let range = Range<String.Index>(start: camelCase.startIndex, end: camelCase.endIndex)
    var underscore = ""
    camelCase.enumerateSubstringsInRange(range, options: options) { (substring, substringRange, enclosingRange, shouldContinue) -> () in
        if let substring = substring {
            if substring.lowercaseString != substring {
                underscore += "_" + substring.lowercaseString
            } else {
                underscore += substring
            }
        }
    }
    return underscore
}

func properties<T>(x: T) -> [(String, MirrorType)] {
    var properties = [(String, MirrorType)]()
    for i in 0..<reflect(x).count {
        properties.append(reflect(x)[i])
    }
    return properties
}