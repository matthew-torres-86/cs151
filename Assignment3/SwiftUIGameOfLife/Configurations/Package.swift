// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Configurations",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Configurations",
            targets: ["Configurations"]
        ),
    ],
    dependencies: [
        .package(path: "../Configuration"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.38.2"))
    ],
    targets: [
        .target(
            name: "Configurations",
            dependencies: [
                "Configuration",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "ConfigurationsTests",
            dependencies: ["Configurations"]),
    ]
)
