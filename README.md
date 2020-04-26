# QuickDB

❗️Save and Retrieve any "Codable" in JUST ONE line of code❗️

Fast usage dataBase to avoid struggling with dataBase complexity. Just save every object with a simple function.

<img src="https://github.com/behrad-kzm/BEKDesing/blob/master/Images/BEKHeader.png">

The QuickDB uses CoreData with a SUPER easy use case that you can store any codable objects and query for them in just 1 line of code.
This component is highly recommended for small scale applications to store user data and settings with custom class types.

[![CI Status](https://img.shields.io/travis/behrad-kzm/QuickDB.svg?style=flat)](https://travis-ci.org/behrad-kzm/QuickDB)
[![Version](https://img.shields.io/cocoapods/v/QuickDB.svg?style=flat)](https://cocoapods.org/pods/QuickDB)
[![License](https://img.shields.io/cocoapods/l/QuickDB.svg?style=flat)](https://cocoapods.org/pods/QuickDB)
[![Platform](https://img.shields.io/cocoapods/p/QuickDB.svg?style=flat)](https://cocoapods.org/pods/QuickDB)

## HOW?

__Step 1:__

Confirm your codable to have a UUID with protocol `QuickIndexable`

```swift
struct MyModel: QuickIndexable {
  let uid = UUID()
  ...
}
```

__Step 2:__

Save your object to QuickDB

```swift
  QuickDB.shared.insert(model: myModel)
```

__Step 3:__

Retrieve all your objects from QuickDB

```swift
QuickDB.shared.getAll(LatestObjects: { (items: [MyModel]) in
      //use your inserted items here
	print(items)
}) { (error) in
	print(error)
}
```

QuickDB uses generic functions to query all records that matches with your Model type.self

## Note

💢Check the example to see how you can `bachInsert`, `delete`, `update` and `tag` your models.

💢There are usecases that optimized for storing large files like `Image`, `Audio`, etc. 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS +11.0
swift 5.0
xcode +11

## Installation

QuickDB is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod 'QuickDB'
```

## Author

behrad-kzm, behradkzm@gmail.com

## License

QuickDB is available under the MIT license. See the LICENSE file for more info.
