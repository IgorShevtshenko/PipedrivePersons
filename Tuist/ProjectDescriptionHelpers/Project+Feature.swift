import ProjectDescription

public extension Project {
    
    static func feature(name: String) -> Self {
        Project(
            name: name,
            packages: [
                .package(path: .relativeToRoot("Core")),
                .package(path: .relativeToRoot("Infrastructure")),
                .package(path: .relativeToRoot("ArchitectureKit")),
                .package(path: .relativeToRoot("Localization")),
                .package(path: .relativeToRoot("UILibrary")),
                .package(path: .relativeToRoot("Utils")),
            ],
            settings: .settings,
            targets: [
                .featureTarget(name: name, product: .staticFramework),
                .featureTarget(name: "\(name)App", product: .app),
                .featureTestTarget(featureName: name)
            ]
        )
    }
}

private extension Target {
    
    static func featureTarget(
        name: String,
        product: Product
    ) -> Target {
        .target(
            name: name,
            destinations: .iOS,
            product: product,
            bundleId: "\(ProjectConfiguration.bundleIdentifier).\(name)",
            deploymentTargets: ProjectConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: "Sources/**",
            dependencies: [
                .package(product: "Domain"),
                .package(product: "ArchitectureKit"),
                .package(product: "Localization"),
                .package(product: "UILibrary"),
                .package(product: "Infrastructure"),
                .package(product: "Utils"),
            ],
            settings: .settings
        )
    }
    
    static func featureTestTarget(
        featureName: String
    ) -> Target {
        .target(
            name: "\(featureName)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConfiguration.bundleIdentifier).\(featureName)Tests",
            deploymentTargets: ProjectConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: "Tests/**",
            dependencies: [
                .package(product: "ArchitectureTesting"),
                .target(name: "\(featureName)App"),
                .xctest
            ],
            settings: .settings
        )
    }
}
