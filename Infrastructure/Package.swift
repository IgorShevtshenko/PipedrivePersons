// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Infrastructure",
            targets: [
                "APIKeyRepository"
            ]
        ),
    ],
    targets: [
        .target(name: "APIKeyRepository"),
    ]
)
