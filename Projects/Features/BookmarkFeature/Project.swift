import ProjectDescription

let project = Project(
  name: "BookmarkFeature",
  targets: [
    .target(
      name: "BookmarkFeatureApp",
      destinations: .iOS,
      product: .app,
      bundleId: "cory.SearchBooks.BookmarkFeatureApp",
      infoPlist: .extendingDefault(
        with: [
          "UILaunchStoryboardName": "LaunchScreen.storyboard",
        ]
      ),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
        .target(name: "BookmarkFeature")
      ]
    ),
    .target(
      name: "BookmarkFeature",
      destinations: .iOS,
      product: .framework,
      bundleId: "cory.SearchBooks.BookmarkFeature",
      infoPlist: .extendingDefault(with: [:]),
      sources: ["Sources/**"],
      resources: [],
      dependencies: [
        .project(target: "Core", path: "../../Core"),
        .project(target: "Data", path: "../../Data"),
      ]
    ),
    .target(
      name: "BookmarkFeatureTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "io.tuist.BookmarkFeatureTests",
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [.target(name: "BookmarkFeature")]
    ),
  ]
)
