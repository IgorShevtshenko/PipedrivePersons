import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PipedrivePersons",
    packages: [
        .package(path: "Core"),
        .package(path: "Infrastructure"),
        .package(path: "InfrastructureImpl"),
        .package(path: "Networking"),
        .package(path: "NetworkingImpl"),
        .package(path: "Utils"),
        .package(path: "ArchitectureKit"),
        .package(path: "Localization")
    ],
    settings: .settings,
    targets: [
        .target(
            name: "PipedrivePersons",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.PipedrivePersons",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["PipedrivePersons/Sources/**"],
            resources: ["Localization/Sources/Localization/**"],
            dependencies: [
                .package(product: "Domain"),
                .package(product: "Infrastructure"),
                .package(product: "InfrastructureImpl"),
                .package(product: "Networking"),
                .package(product: "NetworkingImpl"),
                .package(product: "Utils"),
                .package(product: "ArchitectureKit"),
                .package(product: "Localization")
            ],
            settings: .settings,
            additionalFiles: .testPlans
        )
    ],
    schemes: [
        .scheme(
            name: "UnitTests",
            testAction: .testPlans([.path("UnitTests.xctestplan")])
        )
    ]
)
