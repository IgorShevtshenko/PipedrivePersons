// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Domain",
            targets: [
                "Domain"
            ]
        ),
    ],
    targets: [
        .target(name: "Domain")
    ]
)
