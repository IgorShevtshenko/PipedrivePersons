// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "NetworkingImpl",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "NetworkingImpl",
            targets: ["NetworkingImpl"]
        ),
    ],
    dependencies: [
        .package(path: "./Networking")
    ],
    targets: [
        .target(
            name: "NetworkingImpl",
            dependencies: ["Networking"]
        ),
        .testTarget(
            name: "NetworkingImplTests",
            dependencies: [
                "NetworkingImpl",
                "Networking"
            ]
        ),
    ]
)
