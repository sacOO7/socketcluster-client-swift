// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScClient",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/daltoniam/Starscream.git", .exact("2.1.1")),
    ],
    targets: [
        .target(
            name: "ScClient",
            dependencies: [
                "Starscream",
            ]),
        .target(
            name: "Main",
            dependencies: [
                "ScClient",
            ])
    ]
)
