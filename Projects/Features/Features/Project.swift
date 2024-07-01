import ProjectDescription

let project = Project(
  name: "Features",
  targets: [
    .target(
      name: "Features",
      destinations: .iOS,
      product: .framework,
      bundleId: "cory.SearchBooks.Features",
      infoPlist: .extendingDefault(with: [:]),
      sources: ["Sources/**"],
      resources: [],
      dependencies: [
        .project(target: "SearchBooksFeature", path: "../SearchBooksFeature"),
        .project(target: "BookmarkFeature", path: "../BookmarkFeature")
      ]
    ),
  ]
)
