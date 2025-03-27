// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]
        ),
    ],
    targets: [
        .target(name: "Utils"),
    ]
)
