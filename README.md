# Convertible

Converting your basic types and models to-and-from JSON, binary data, etc. is a common task in application development. `Convertible` defines a collection of Swift protocols and implementations that makes the conversion process easy, so you don't have to write boilerplate code.

- [Installation](#installation)
- [Data](#data)
  - [DataConvertible](#dataconvertible)
- [JSON](#json)
  - [JsonConvertible](#jsonconvertible)
  - [JsonValue](#jsonvalue)
- [Models](#models)
  - [Key Mapping](#key-mapping)
  - [Validation](#validation)
- [Author](#author)
- [License](#license)

## Installation

`Convertible` is available through [CocoaPods](http://cocoapods.org). To install, simply include the following lines in your podfile:
```ruby
use_frameworks!
pod 'Convertible'
```
Be sure to import the module at the top of your .swift files:
```swift
import Convertible
```
Alternatively, clone this repo or download it as a zip and include the classes in your project.

## Data

In iOS/OSX development, working with `NSData` is a given. `Convertible` makes it easy to convert your Swift and Cocoa types, as well as your own custom models, to-and-from NSData. 

### `DataConvertible`

The `Convertible` framework defines a universal protocol `DataConvertible` for conversions to-and-from NSData:
```swift
protocol DataConvertible : DataInitializable, DataSerializable {
    
    static func initializeWithData(data: NSData, options: [ConvertibleOption]) throws -> Self
    
    func serializeToDataWithOptions(options: [ConvertibleOption]) throws -> NSData
    
}
```
`DataConvertible` makes it easy to create any conforming type from an `NSData` object (and easy to serialize back to `NSData`):
```swift
let data = // Some arbitrary NSData...
let string = try String.initializeWithData(data, options: [])
let newData = try string.serializeToDataWithOptions([])
```
Default implementations are included for the following types:
```swift
NSString
NSArray
NSDictionary
NSSet
NSImage
UIImage
Swift.String
Swift.Array
Swift.Dictionary
Swift.Set
```
Types from the `Convertible` framework such as `Convertible` or `JsonValue` also implement `DataConvertible`. You can extend your own custom types to implement `DataConvertible` to take advantage of this powerful convention.

## JSON

### `JsonConvertible`

### `JsonValue`

## Models

`Convertible` makes defining your models easy. Simply create a class that inherits from `Convertible` and you're all set!
```swift
class User : Convertible {
  var id: Int = 0
  var name: String?
  var friend: User?
  var created: NSDate?
}
```
`Convertible` implements all conversion protocols. So creating a new `User` from NSData is easy:
```swift
let data = // Some JSON NSData from a HTTP request...
let user = try User.initializeWithData(data)
```
Be aware that because `Convertible` relies on Key-Value Coding (KVC), any property that is unsupported by KVC will also be unsupported by `Convertible` (e.g., optional Swift types that cannot be bridged to Objective-C like `Int?`).

### Key Mapping

The defacto standard for JSON key values is snake case (i.e., this_is_a_json_property) instead of camel case. `Convertible` supports automatic mapping from underscores to camel case right out of the box. Just add the `UnderscoreToCamelCase` protocol to your model definition:
```swift
class User : Convertible, UnderscoreToCamelCase {
  var firstName: String?
  var lastName: String?
  var bestFriend: User?
  var createdAt: NSDate?
}
```
You can also specify custom key mapping. Just implement the `CustomKeyMapping` protocol:
```swift
class User : Convertible, UnderscoreToCamelCase, CustomKeyMapping {
  var firstName: String?
  var lastName: String?
  var isPublic: Bool = false
  var keyMapping = ["isPublic":"public"] // [PropertyKey: JsonKey]
}
```
If you need certain properties to be ignored, implement the `IgnoredKeys` protocol:
```swift
class User : Convertible, IgnoredKeys {
  var id: Int = 0
  var name: String?
  var isLocalModel: Bool = true
  var ignoredKeys = ["isLocalModel"]
}
```

### Validation

By default all model properties are optional. If you'd like model initialization to fail if critical keys are missing, you can add the `RequiredKeys` protocol:
```swift
class User : Convertible, RequiredKeys {
  var id: Int = 0
  var name: String?
  var friend: User?
  var created: NSDate?
  var requiredKeys = ["id", "name"]
}
```
You can use the `OptionalKeys` protocol instead if you'd like all but the keys you specify be required by default:
```swift
class User : Convertible, OptionalKeys {
  var id: Int = 0
  var name: String?
  var friend: User?
  var created: NSDate?
  var optionalKeys = ["friend"] // Now id, name, and created are all required keys
}
```

## Author

Brad Hilton, brad@skyvive.com

## License

`Convertible` is available under the MIT license. See the LICENSE file for more info.
