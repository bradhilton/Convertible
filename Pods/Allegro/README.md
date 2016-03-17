# Allegro

`Allegro` is an advanced Swift reflection utility that allows you to create classes and structs at run-time:
```swift
struct Person {
   var name: String
   var age: Int
   var friends: [Person]
}
// Returns fields for Person
let fields = try fieldsForType(Person)
// Constructs Person
let person: Person = try constructType { field in
  // return value for field
}
```
Be aware that every property of the type you'd like to construct must conform to `Property`.

## Installation

### CocoaPods

`Allegro` is available through [CocoaPods](http://cocoapods.org). To install, simply include the following lines in your podfile:
```ruby
use_frameworks!
pod 'Allegro'
```
Be sure to import the module at the top of your .swift files:
```swift
import Allegro
```
### Carthage
`Allegro` is also available through [Carthage](https://github.com/Carthage/Carthage). Just add the following to your cartfile:
```
github "bradhilton/Allegro"
```
Be sure to import the module at the top of your .swift files:
```swift
import Allegro
```
### Swift Package Manager
You can also build `Allegro` using the [Swift Package Manager](https://github.com/apple/swift-package-manager). Just include `Allegro` as a package in your dependencies:
```
.Package(url: "https://github.com/bradhilton/Allegro.git", majorVersion: 1)
```
Be sure to import the module at the top of your .swift files:
```swift
import Allegro
```

## Revision History

* 1.0.0 - Initial Release

## Author

Brad Hilton, brad@skyvive.com

## License

`Allegro` is available under the MIT license. See the LICENSE file for more info.


