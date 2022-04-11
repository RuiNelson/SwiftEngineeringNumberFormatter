// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftEngineeringNumberFormatter",
    products: [
        .library(
            name: "SwiftEngineeringNumberFormatter",
            targets: ["SwiftEngineeringNumberFormatter"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftEngineeringNumberFormatter",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftEngineeringNumberFormatterTests",
            dependencies: ["SwiftEngineeringNumberFormatter"]
        ),
    ]
)
