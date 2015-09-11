//
//  Keys2.swift
//  Convertible
//
//  Created by Bradley Hilton on 9/10/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public typealias PropertyKey = String
public typealias MappedKey = String

public protocol KeyMapping {
    
    static var keyMapping: [PropertyKey : MappedKey] { get }
    static func mappedKeyForPropertyKey(propertyKey: PropertyKey) -> MappedKey
    
}

public protocol UnderscoreToCamelCase : KeyMapping {}

public protocol IgnoredKeys {
    
    static var ignoredKeys: [String] { get }
    static func isIgnoredKey(key: String) -> Bool
    
}

public protocol OptionalKeys {
    
    static var optionalKeys: [String] { get }
    static func isOptionalKey(key: String) -> Bool
    
}

public protocol OptionalsAsOptionalKeys : OptionalKeys {
    
}

public protocol Keys : KeyMapping, IgnoredKeys, OptionalKeys {
    
}

extension KeyMapping {
    
    public static var keyMapping: [PropertyKey : MappedKey] {
        return [:]
    }
    
    public static func mappedKeyForPropertyKey(propertyKey: PropertyKey) -> MappedKey {
        if let mappedKey = keyMapping[propertyKey] {
            return mappedKey
        } else {
            return propertyKey
        }
    }
    
}

extension UnderscoreToCamelCase {
    
    public static func mappedKeyForPropertyKey(propertyKey: PropertyKey) -> MappedKey {
        if let mappedKey = keyMapping[propertyKey] {
            return mappedKey
        } else {
            return underscoreFromCamelCase(propertyKey)
        }
    }
    
    static func underscoreFromCamelCase(camelCase: PropertyKey) -> MappedKey {
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
    
}

extension IgnoredKeys {
    
    public static var ignoredKeys: [String] {
        return []
    }
    
    public static func isIgnoredKey(key: String) -> Bool {
        return self.ignoredKeys.contains(key)
    }
    
}

extension OptionalKeys {
    
    public static var optionalKeys: [String] {
        return []
    }
    
    public static func isOptionalKey(key: String) -> Bool {
        return self.optionalKeys.contains(key)
    }
    
}

struct Key {
    
    let key: String
    let mappedKey: String
    let value: Any
    
    var type: Any.Type {
        return value.dynamicType
    }
    
}

extension Keys {
    
    internal var allKeys: [Key] {
        return keys(true)
    }
    
    internal var requiredKeys: [Key] {
        return keys(false)
    }
    
    private func isRequiredKey(value: Any, key: String) -> Bool {
        return !(self.dynamicType.isOptionalKey(key) || (self is OptionalsAsOptionalKeys && value is OptionalProtocol))
    }
    
    private func keys(includeOptional: Bool) -> [Key] {
        let this = self.dynamicType
        var keys = [Key]()
        for child in Mirror(reflecting: self).children {
            if let key = child.label where !this.isIgnoredKey(key) && (includeOptional || isRequiredKey(child.value, key: key)) {
                keys.append(Key(key: key, mappedKey: this.mappedKeyForPropertyKey(key), value: child.value))
            }
        }
        return keys
    }
    
}

