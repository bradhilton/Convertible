//
//  TypeConstructor.swift
//  Allegro
//
//  Created by Bradley Hilton on 3/17/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

public func constructType<T>(constructor: Field throws -> Any) throws -> T {
    guard Metadata.Struct(type: T.self) != nil else { throw Error.NotStruct(type: T.self) }
    let pointer = UnsafeMutablePointer<T>.alloc(1)
    defer { pointer.dealloc(1) }
    var storage = UnsafeMutablePointer<Int>(pointer)
    var values = [Any]()
    try constructType(&storage, values: &values, fields: fieldsForType(T.self), constructor: constructor)
    return pointer.memory
}

private func constructType(inout storage: UnsafeMutablePointer<Int>, inout values: [Any], fields: [Field], constructor: Field throws -> Any) throws {
    for field in fields {
        var value = try constructor(field)
        guard instanceValue(value, isOfType: field.type) else {
            throw Error.ValueIsNotOfType(value: value, type: field.type)
        }
        values.append(value)
        storage.consumeBuffer(bufferForInstance(&value))
    }
}
