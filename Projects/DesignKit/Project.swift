import ProjectDescription

let project = Project(
  name: "DesignKit",
  targets: [
    .target(
      name: "DesignKit",
      destinations: .iOS,
      product: .framework,
      bundleId: "cory.SearchBooks.DesignKit",
      infoPlist: .extendingDefault(with: [:]),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
        .project(target: "Domain", path: "../Domain")
      ]
    ),
  ]
)
