// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScClient",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/daltoniam/Starscream.git", .exact("2.1.1")),
        .package(url: "https://github.com/alibaba/HandyJSON.git", .exact("1.8.0")),
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
