// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "UILibrary",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "UILibrary",
            targets: ["UILibrary"]
        ),
    ],
    targets: [
        .target(name: "UILibrary"),
    ]
)
