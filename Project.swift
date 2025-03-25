import ProjectDescription

let project = Project(
    name: "PipedrivePersons",
    targets: [
        .target(
            name: "PipedrivePersons",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.PipedrivePersons",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["PipedrivePersons/Sources/**"],
            dependencies: []
        )
    ]
)
