// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Netify",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "Netify",
            targets: ["Netify"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Netify",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "NetifyTests",
            dependencies: ["Netify"],
            path: "Tests"
        ),
    ]
)
