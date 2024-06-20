// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
  // Customize the product types for specific package product
  // Default is .staticFramework
  // productTypes: ["Alamofire": .framework,]
  productTypes: ["SwiftUIIntrospect": .framework]
)
#endif

let package = Package(
  name: "SampleTuist",
  dependencies: [
    .package(url: "https://github.com/siteline/swiftui-introspect", from: "1.0.0")
    // Add your own dependencies here:
    // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
    // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
  ]
)
