//
//  Allegro.swift
//  Allegro
//
//  Created by Bradley Hilton on 1/26/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

public protocol Property {}

public func constructType<T>(constructor: Field throws -> Property) throws -> T {
    let pointer = UnsafeMutablePointer<T>.alloc(1)
    var words = getWords(pointer)
    var values = [Any]()
    try constructType(&words, values: &values, fields: fieldsForType(T.self), constructor: constructor)
    return pointer.memory
}

private typealias FieldTypesFunction = @convention(c) UnsafePointer<Int> -> UnsafePointer<UnsafePointer<Int>>

func getWords<T>(pointer: UnsafeMutablePointer<T>) -> UnsafeMutablePointer<Int> {
    if T.self is AnyClass {
        var this: Any = T.self
        var base = NonObjectiveCBase()
        let words = UnsafeMutablePointer<Int>.alloc(32)
        words[0] = memory(&this, 0)
        words[1] = memory(&base, 0, 1)
        UnsafeMutablePointer<Int>(pointer).memory = words.hashValue
        return words.advancedBy(2)
    }
    return UnsafeMutablePointer(pointer)
}

private func constructType(inout words: UnsafeMutablePointer<Int>, inout values: [Any], fields: [Field], constructor: Field throws -> Property) throws {
    for field in fields {
        var value = try constructor(field)
        guard let type = field.type as? Property.Type else { throw Error.NotProperty(type: field.type) }
        guard type.isTypeOfValue(value) else { throw Error.ValueIsNotType(value: value, type: field.type) }
        values.append(value)
        appendWords(&words, words: value.words())
    }
}

public struct Field {
    public let name: String
    public let type: Any.Type
    init(name: String, metadataPointer: UnsafePointer<Int>) throws {
        self.name = name
        self.type = try constructPropertyType(metadataPointer)
    }
}

extension Property {
    
    private mutating func words() -> [Int] {
        let pointer = withUnsafePointer(&self) { UnsafePointer<Int>($0) }
        return (0..<wordsize(sizeofValue(self))).map { pointer[$0] }
    }
    
    private static func isTypeOfValue(value: Property) -> Bool {
        return value is Self
    }
    
}

private func wordsize(size: Int) -> Int {
    return (size / sizeof(Int)) + (size % sizeof(Int) == 0 ? 0 : 1)
}

public func fieldsForType(type: Any.Type) throws -> [Field] {
    return type is AnyClass ? try fields(type, offset: sizeof(Int) == 8 ? 8 : 11, condition: { $0 > 4096 }) : try fields(type, offset: 1, condition: { $0 == 1 })
}

private func fields(type: Any.Type, offset: Int, condition: Int -> Bool) throws -> [Field] {
    var copy: Any = type
    guard condition(memory(&copy, 0, 0) as Int) else { throw Error.NotClassOrStruct(type: type) }
    let numberOfFields = Int(memory(&copy, 0, offset, 2) as Int8)
    let names = fieldNames(memory(&copy, 0, offset, 3), numberOfFields: numberOfFields)
    let pointers = fieldPointers(memory(&copy, 0, offset, 4), pointer: memory(&copy, 0), numberOfFields: numberOfFields)
    return try (0..<numberOfFields).map { try Field(name: names[$0], metadataPointer: pointers[$0])}
}

private func fieldNames(var pointer: UnsafePointer<CChar>, numberOfFields: Int) -> [String] {
    return (0..<numberOfFields).map { _ in
        defer {
            while pointer.memory != 0 {
                pointer = pointer.successor()
            }
            pointer = pointer.successor()
        }
        return String.fromCString(pointer) ?? ""
    }
}

private func fieldPointers(function: FieldTypesFunction?, pointer: UnsafePointer<Int>, numberOfFields: Int) -> [UnsafePointer<Int>] {
    guard let function = function else { return [] }
    return (0..<numberOfFields).map { function(pointer).advancedBy($0).memory }
}

private func constructPropertyType(metadataPointer: UnsafePointer<Int>) throws -> Any.Type {
    let pointer = UnsafeMutablePointer<Any.Type>.alloc(1)
    let intPointer = UnsafeMutablePointer<Int>(pointer)
    intPointer.memory = metadataPointer.hashValue
    return pointer.memory
}

private func appendWords(inout pointer: UnsafeMutablePointer<Int>, words: [Int]) {
    for word in words {
        pointer.memory = word
        pointer = pointer.successor()
    }
}

public enum Error : ErrorType, CustomStringConvertible {
    
    case NotClassOrStruct(type: Any.Type)
    case NotProperty(type: Any.Type)
    case ValueIsNotType(value: Any, type: Any.Type)
    
    public var description: String {
        return "Allegro Error: \(caseDescription)"
    }
    
    var caseDescription: String {
        switch self {
        case .NotClassOrStruct(type: let type): return "\(type) is not a class or struct"
        case .NotProperty(type: let type): return "\(type) does not conform to Property"
        case .ValueIsNotType(value: let value, type: let type): return "Cannot set value of type \(value.dynamicType) as \(type)"
        }
    }
}

private func memory<T, U>(inout memory: T, _ path: Int...) -> U {
    var pointer = withUnsafePointer(&memory, memoryPointer)
    path.forEach { pointer = UnsafePointer<Int>(bitPattern: pointer.memory).advancedBy($0) }
    return UnsafePointer<U>(pointer).memory
}

private func memoryPointer<T>(memory: UnsafePointer<T>) -> UnsafePointer<Int> {
    let pointer = UnsafeMutablePointer<Int>.alloc(1)
    pointer.initialize(memory.hashValue)
    return UnsafePointer(pointer)
}
