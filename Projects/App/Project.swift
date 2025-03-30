import ProjectDescription
import ProjectDescriptionHelpers

let app = Project(
    name: "PipedrivePersons",
    packages: [
        .package(path: .relativeToRoot("Core")),
        .package(path: .relativeToRoot("Infrastructure")),
        .package(path: .relativeToRoot("InfrastructureImpl")),
        .package(path: .relativeToRoot("Networking")),
        .package(path: .relativeToRoot("NetworkingImpl")),
        .package(path: .relativeToRoot("Utils")),
        .package(path: .relativeToRoot("ArchitectureKit")),
        .package(path: .relativeToRoot("Localization")),
        .package(path: .relativeToRoot("UILibrary")),
    ],
    settings: .settings,
    targets: [
        .target(
            name: "PipedrivePersons",
            destinations: .iOS,
            product: .app,
            bundleId: ProjectConfiguration.bundleIdentifier,
            deploymentTargets: ProjectConfiguration.deploymentTarget,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": ""
                ]
            ),
            sources: ["Sources/**"],
            resources: ["../../Localization/Sources/Localization/Localisables/**"],
            dependencies: [
                .package(product: "Domain"),
                .package(product: "Infrastructure"),
                .package(product: "InfrastructureImpl"),
                .package(product: "Networking"),
                .package(product: "NetworkingImpl"),
                .package(product: "Utils"),
                .package(product: "ArchitectureKit"),
                .package(product: "Localization"),
                .package(product: "UILibrary"),
                .project(target: "Persons", path: "../Features/Persons")
            ],
            settings: .settings,
            additionalFiles: .testPlans
        ),
    ],
    schemes: [
        .scheme(
            name: "UnitTests",
            testAction: .testPlans([.relativeToRoot("UnitTests.xctestplan")])
        )
    ]
)
