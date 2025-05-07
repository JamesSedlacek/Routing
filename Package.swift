// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Routing",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "Routing",
            targets: ["Routing"]
        ),
        .executable(
            name: "ExampleApp",
            targets: ["ExampleApp"]
        )
    ],
    targets: [
        .target(name: "Routing"),
        .executableTarget(
            name: "ExampleApp",
            dependencies: ["Routing"],
            path: "ExampleApp"
        ),
        .testTarget(
            name: "RoutingTests",
            dependencies: ["Routing"]
        ),
    ]
)
