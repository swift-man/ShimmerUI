// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "ShimmerUI",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .tvOS(.v15),
    .watchOS(.v8)
  ],
  products: [
    .library(
      name: "ShimmerUI",
      targets: ["ShimmerUI"]
    )
  ],
  targets: [
    .target(
      name: "ShimmerUI",
      path: "Sources/ShimmerUI"
    ),
    .testTarget(
      name: "ShimmerUITests",
      dependencies: ["ShimmerUI"],
      path: "Tests/ShimmerUITests"
    )
  ],
  swiftLanguageModes: [.v5]
)
