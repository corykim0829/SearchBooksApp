import ProjectDescription

let project = Project(
  name: "SearchBooksApp",
  targets: [
    .target(
      name: "SearchBooksApp",
      destinations: .iOS,
      product: .app,
      bundleId: "cory.SearchBooks.SearchBooksApp",
      infoPlist: .extendingDefault(
        with: [
          "UILaunchStoryboardName": "LaunchScreen.storyboard",
        ]
      ),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
        .project(target: "Features", path: "../Features/Features")
      ]
    )
  ]
)
