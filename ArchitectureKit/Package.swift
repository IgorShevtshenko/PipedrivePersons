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
    ],
    dependencies: [
        .package(path: "./Utils")
    ],
    targets: [
        .target(name: "ArchitectureKit"),
        .testTarget(
            name: "ArchitectureKitTests",
            dependencies: [
                "ArchitectureKit",
                "Utils",
            ]
        ),
    ]
)
