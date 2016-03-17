//
//  Allegro.swift
//  Allegro
//
//  Created by Bradley Hilton on 1/26/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

var is64BitPlatform: Bool {
    return sizeof(Int) == sizeof(Int64)
}

public struct Field {
    public let name: String
    public let type: Any.Type
    let offset: Int
}

public func fieldsForType(type: Any.Type) throws -> [Field] {
    guard let nominalType = Metadata(type: type).nominalType else {
        throw Error.NotStructOrClass(type: type)
    }
    let fieldNames = nominalType.nominalTypeDescriptor.fieldNames
    let fieldTypes = nominalType.fieldTypes ?? []
    var offset = 0
    return (0..<nominalType.nominalTypeDescriptor.numberOfFields).map { i in
        defer { offset += wordSizeForType(fieldTypes[i]) }
        return Field(name: fieldNames[i], type: fieldTypes[i], offset: offset)
    }
}

public struct Property {
    public let key: String
    public let value: Any
}

public func propertiesForInstance(instance: Any) throws -> [Property] {
    let fields = try fieldsForType(instance.dynamicType)
    var copy = instance
    var storage = storageForInstance(&copy)
    return fields.map { nextPropertyForField($0, pointer: &storage) }
}

private func nextPropertyForField(field: Field, inout pointer: UnsafePointer<Int>) -> Property {
    defer { pointer = pointer.advancedBy(wordSizeForType(field.type)) }
    return Property(key: field.name, value: AnyExistentialContainer(type: field.type, pointer: pointer).any)
}