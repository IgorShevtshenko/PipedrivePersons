// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
    ],
    targets: [
        .target(name: "Networking"),
    ]
)
