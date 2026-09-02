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
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-bit.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-finite.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Byte",
            dependencies: [
                .product(name: "Bit", package: "swift-bit"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Finite Bounded", package: "swift-finite"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Byte Standard Library Integration",
            dependencies: [
                .target(name: "Byte")
            ]
        ),
        .testTarget(
            name: "Byte Tests",
            dependencies: [
                .target(name: "Byte"),
                .product(name: "Bit", package: "swift-bit"),
            ]
        ),
        .testTarget(
            name: "Byte Standard Library Integration Tests",
            dependencies: [
                .target(name: "Byte"),
                .target(name: "Byte Standard Library Integration"),
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
