// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "InfrastructureImpl",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "InfrastructureImpl",
            targets: ["APIKeyRepositoryImpl"]
        ),
    ],
    dependencies: [
        .package(path: "./Infrastructure")
    ],
    targets: [
        .target(
            name: "APIKeyRepositoryImpl",
            dependencies: ["Infrastructure"]
        ),
        .testTarget(
            name: "InfrastructureTests"
        ),
    ]
)
