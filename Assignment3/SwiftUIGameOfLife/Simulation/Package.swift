// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Simulation",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Simulation",
            targets: ["Simulation"]
        ),
    ],
    dependencies: [
        .package(path: "../Grid"),
        .package(path: "../GameOfLife"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.28.1"))
    ],
    targets: [
        .target(
            name: "Simulation",
            dependencies: [
                "Grid",
                "GameOfLife",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "SimulationTests",
            dependencies: ["Simulation"]
        ),
    ]
)
