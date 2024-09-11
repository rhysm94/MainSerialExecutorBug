// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MainSerialExecutorBug",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "MainSerialExecutorBug",
      targets: ["MainSerialExecutorBug"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-concurrency-extras", from: "1.0.0")
  ],
  targets: [
    .target(name: "MainSerialExecutorBug"),
    .testTarget(
      name: "MainSerialExecutorBugTests",
      dependencies: [
        "MainSerialExecutorBug",
        .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras")
      ]
    ),
  ]
)
