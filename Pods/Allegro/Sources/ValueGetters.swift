//
//  ValueGetters.swift
//  Allegro
//
//  Created by Bradley Hilton on 3/17/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

public func valueForKey(key: String, ofInstance instance: Any) throws -> Any {
    for property in try propertiesForInstance(instance) {
        if property.key == key {
            return property.value
        }
    }
    throw Error.InstanceHasNoKey(type: instance.dynamicType, key: key)
}

public func valueForKey<T>(key: String, ofInstance instance: Any) throws -> T {
    let any: Any = try valueForKey(key, ofInstance: instance)
    guard let value = any as? T else {
        throw Error.ValueIsNotOfType(value: any, type: T.self)
    }
    return value
}
