import ProjectDescription

let project = Project(
  name: "SearchBooksFeature",
  targets: [
    .target(
      name: "SearchBooksFeatureApp",
      destinations: .iOS,
      product: .app,
      bundleId: "cory.SearchBooks.SearchBooksFeatureApp",
      infoPlist: .extendingDefault(
        with: [
          "UILaunchStoryboardName": "LaunchScreen.storyboard",
        ]
      ),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
        .target(name: "SearchBooksFeature")
      ]
    ),
    .target(
      name: "SearchBooksFeature",
      destinations: .iOS,
      product: .framework,
      bundleId: "cory.SearchBooks.SearchBooksFeature",
      infoPlist: .extendingDefault(with: [:]),
      sources: ["Sources/**"],
      resources: [],
      dependencies: [
        .project(target: "Core", path: "../../Core"),
        .project(target: "DesignKit", path: "../../DesignKit"),
        .external(name: "SwiftUIIntrospect")
      ]
    ),
    .target(
      name: "SearchBooksFeatureTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "cory.SearchBooks.SearchBooksFeatureTests",
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [.target(name: "SearchBooksFeature")]
    ),
  ]
)
