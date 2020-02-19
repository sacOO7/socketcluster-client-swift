// swift-tools-version:4.0
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
        .package(url: "https://github.com/daltoniam/Starscream.git", .exact("3.1.1")),
        .package(url: "https://github.com/alibaba/HandyJSON.git", .exact("5.0.1")),
        .package(url: "https://github.com/Quick/Quick.git", .exact("2.2.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .exact("8.0.2")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "5.0.0")
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
            name: "Integration",
            dependencies: [
                "ScClient",
                "Quick",
                "Nimble",
                "RxSwift"
                ]),
        .testTarget(
            name: "Unit",
            dependencies: [
                "ScClient"
                ])
        ]
)
