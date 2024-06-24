import ProjectDescription

let project = Project(
    name: "SearchBooks",
    targets: [
        .target(
            name: "SearchBooks",
            destinations: .iOS,
            product: .app,
            bundleId: "cory.SearchBooks",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["SearchBooks/Sources/**"],
            resources: ["SearchBooks/Resources/**"],
            dependencies: [.external(name: "SwiftUIIntrospect")]
        ),
        .target(
            name: "SearchBooksTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "cory.SearchBooksTests",
            infoPlist: .default,
            sources: ["SearchBooks/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SearchBooks")]
        ),
    ]
)
