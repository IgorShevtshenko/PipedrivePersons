import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PipedrivePersons",
    packages: [
        .package(path: "Infrastructure"),
        .package(path: "InfrastructureImpl"),
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
            dependencies: [
                .package(product: "Infrastructure"),
                .package(product: "InfrastructureImpl"),
            ],
            settings: .settings
        )
    ]
)
