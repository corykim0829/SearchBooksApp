import ProjectDescription

let project = Project(
  name: "Domain",
  targets: [
    .target(
      name: "Domain",
      destinations: .iOS,
      product: .framework,
      bundleId: "cory.SearchBooks.Domain",
      infoPlist: .extendingDefault(with: [:]),
      sources: ["Sources/**"],
      resources: [],
      dependencies: [
        .external(name: "Realm"),
        .external(name: "RealmSwift")
      ]
    )
  ]
)
