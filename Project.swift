import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PipedrivePersons",
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
            resources: [
                .glob(pattern: "PipedrivePersons/OnDemandResources/APIKey.json", tags: ["APIKey"])
            ],
            dependencies: [],
            settings: .settings,
            onDemandResourcesTags: .tags(initialInstall: ["APIKey"], prefetchOrder: [])
        )
    ]
)
