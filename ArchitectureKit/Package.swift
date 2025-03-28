// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "ArchitectureKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ArchitectureKit",
            targets: ["ArchitectureKit"]
        ),
        .library(
            name: "ArchitectureTesting",
            targets: ["ArchitectureTesting"]
        )
    ],
    dependencies: [
        .package(path: "./Utils")
    ],
    targets: [
        .target(name: "ArchitectureKit"),
        .target(
            name: "ArchitectureTesting",
            dependencies: ["Utils"]
        ),
        .testTarget(
            name: "ArchitectureKitTests",
            dependencies: [
                "ArchitectureKit",
                "ArchitectureTesting",
                "Utils",
            ]
        ),
    ]
)
