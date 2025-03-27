// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Infrastructure",
            targets: [
                "APIKeyRepository",
                "PersonsRepository"
            ]
        ),
    ],
    dependencies: [
        .package(path: "./Core"),
        .package(path: "./Utils")
    ],
    targets: [
        .target(name: "APIKeyRepository"),
        .target(
            name: "PersonsRepository",
            dependencies: [
                "Utils",
                .product(name: "Domain", package: "Core")
            ]
        ),
    ]
)
