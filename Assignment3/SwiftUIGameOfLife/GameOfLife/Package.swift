// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "GameOfLife",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "GameOfLife",
            targets: ["GameOfLife"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "GameOfLife",
            dependencies: []
        ),
        .testTarget(
            name: "GameOfLifeTests",
            dependencies: ["GameOfLife"]
        ),
    ]
)
