import ProjectDescription

let project = Project(
  name: "Data",
  targets: [
    .target(
      name: "Data",
      destinations: .iOS,
      product: .framework,
      bundleId: "cory.SearchBooks.Data",
      infoPlist: .extendingDefault(with: [:]),
      sources: ["Sources/**"],
      resources: [],
      dependencies: [
        .project(target: "Domain", path: "../Domain"),
        .external(name: "Realm"),
        .external(name: "RealmSwift")
      ]
    ),
  ]
)
