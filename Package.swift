// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScClient",
    products: [
        .library(
            name: "ScClient",
            targets: ["ScClient"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/daltoniam/Starscream.git", .exact("3.0.4")),
        .package(url: "https://github.com/alibaba/HandyJSON.git", .exact("4.2.0")),
        ],
    targets: [
        .target(
            name: "ScClient",
            dependencies: [
                "Starscream",
                "HandyJSON"
                ]),
        .target(
            name: "Main",
            dependencies: [
                "ScClient",
                ]),
        .testTarget(
            name: "ScClientTests",
            dependencies: ["ScClient"])
        ]
)
