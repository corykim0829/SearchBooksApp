import ProjectDescription

let project = Project(
  name: "Core",
  targets: [
    .target(
      name: "Core",
      destinations: .iOS,
      product: .framework,
      bundleId: "cory.SearchBooks.Core",
      infoPlist: .extendingDefault(with: [:]),
      sources: ["Sources/**"],
      resources: [],
      dependencies: []
    ),
  ]
)
