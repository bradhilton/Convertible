//
//  Properties.swift
//  Convertibles
//
//  Created by Bradley Hilton on 6/9/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol UnderscoreToCamelCase {}

public protocol CustomKeyMapping {
    
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

public protocol AllRequiredKeys {}

public protocol OptionalsAsOptionalKeys {}

let ignoredKeys = ["super", "keyMapping", "ignoredKeys", "requiredKeys", "optionalKeys"]

public struct Key {
    
    let object: Any
    public let key: String
    let value: Any
    let valueType: Any.Type
    let summary: String
    
}

extension Key {
    
    var mappedKey: String {
        var mappedKey = key
        if let object = object as? CustomKeyMapping, let customKey = object.keyMapping[key] {
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
    } else if let object = object as? OptionalsAsOptionalKeys {
        return allKeys(object).filter { !($0.valueType is OptionalProtocol.Type) }
    } else if let object = object as? AllRequiredKeys {
        return allKeys(object)
    } else {
        return [Key]()
    }
}

func allKeys(object: Any) -> [Key] {
    var keys = [Key]()
    for child in Mirror(reflecting: object).children {
        if let key = child.label {
            if ignoredKeys.contains(key) {
                continue
            } else if let object = object as? IgnoredKeys where object.ignoredKeys.contains(key) {
                continue
            } else {
                keys.append(Key(object: object, key: key, value: child.value, valueType: child.value.dynamicType, summary: String(child.value)))
            }
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