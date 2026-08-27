// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-byte",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Byte",
            targets: ["Byte"]
        ),
        .library(
            name: "Byte Standard Library Integration",
            targets: ["Byte Standard Library Integration"]
        ),
        .library(
            name: "Byte Apple Foundation Integration",
            targets: ["Byte Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Byte",
            dependencies: []
        ),
        .target(
            name: "Byte Standard Library Integration",
            dependencies: ["Byte"]
        ),
        .target(
            name: "Byte Apple Foundation Integration",
            dependencies: [
                "Byte",
                "Byte Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Byte Tests",
            dependencies: ["Byte"]
        ),
        .testTarget(
            name: "Byte Standard Library Integration Tests",
            dependencies: [
                "Byte",
                "Byte Standard Library Integration",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
