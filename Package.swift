// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CollectionKitReloadable",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "CollectionKitReloadable", targets: ["CollectionKitReloadable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/faberNovel/CompositionalLayoutDSL.git", from: "0.2.0"),
        .package(url: "https://github.com/dankinsoid/CellsReloadable.git", from: "1.1.2")
    ],
    targets: [
        .target(
            name: "CollectionKitReloadable",
            dependencies: [
                "CompositionalLayoutDSL",
                "CellsReloadable"
            ]
        )
    ]
)
