# SwiftFirebaseTools

[![CI Status](https://img.shields.io/travis/dankinsoid/SwiftFirebaseTools.svg?style=flat)](https://travis-ci.org/dankinsoid/SwiftFirebaseTools)
[![Version](https://img.shields.io/cocoapods/v/SwiftFirebaseTools.svg?style=flat)](https://cocoapods.org/pods/SwiftFirebaseTools)
[![License](https://img.shields.io/cocoapods/l/SwiftFirebaseTools.svg?style=flat)](https://cocoapods.org/pods/SwiftFirebaseTools)
[![Platform](https://img.shields.io/cocoapods/p/SwiftFirebaseTools.svg?style=flat)](https://cocoapods.org/pods/SwiftFirebaseTools)


## Description
This repository provides

## Example

```swift

```
## Usage

 
## Installation

1. [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.
```swift
// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "SomeProject",
  dependencies: [
    .package(url: "https://github.com/dankinsoid/SwiftFirebaseTools.git", from: "0.0.4")
  ],
  targets: [
    .target(name: "SomeProject", dependencies: ["SwiftFirebaseTools"])
  ]
)
```
```ruby
$ swift build
```

2.  [CocoaPods](https://cocoapods.org)

Add the following line to your Podfile:
```ruby
pod 'SwiftFirebaseTools'
```
and run `pod update` from the podfile directory first.

## Author

dankinsoid, voidilov@gmail.com

## License

SwiftFirebaseTools is available under the MIT license. See the LICENSE file for more info.
