// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "InfrastructureImpl",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "InfrastructureImpl",
            targets: [
                "APIKeyRepositoryImpl",
                "PersonsRepositoryImpl"
            ]
        )
    ],
    dependencies: [
        .package(path: "./Infrastructure"),
        .package(path: "./Networking"),
        .package(path: "./Core")
    ],
    targets: [
        .target(
            name: "APIKeyRepositoryImpl",
            dependencies: [
                "Infrastructure",
                "Networking"
            ]
        ),
        .target(
            name: "PersonsRepositoryImpl",
            dependencies: [
                "Infrastructure",
                "Networking",
                .product(name: "Domain", package: "Core")
            ]
        ),
        .testTarget(
            name: "InfrastructureTests",
            dependencies: [
                "PersonsRepositoryImpl",
                "Networking",
                .product(name: "Domain", package: "Core")
            ]
        )
    ]
)
