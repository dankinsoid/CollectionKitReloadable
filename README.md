# CollectionKitReloadable

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
    .package(url: "https://github.com/dankinsoid/CollectionKitReloadable.git", from: "0.0.1")
  ],
  targets: [
    .target(name: "SomeProject", dependencies: ["CollectionKitReloadable"])
  ]
)
```
```ruby
$ swift build
```

## Author

dankinsoid, voidilov@gmail.com

## License

CollectionKitReloadable is available under the MIT license. See the LICENSE file for more info.
