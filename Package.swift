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
            name: "Byte Primitive",
            targets: ["Byte Primitive"]
        ),
        .library(
            name: "Byte Protocol",
            targets: ["Byte Protocol"]
        ),
        .library(
            name: "Byte Borrowed",
            targets: ["Byte Borrowed"]
        ),
        .library(
            name: "Byte Tagged",
            targets: ["Byte Tagged"]
        ),
        .library(
            name: "Byte Bit",
            targets: ["Byte Bit"]
        ),
        .library(
            name: "Byte",
            targets: ["Byte"]
        ),
        .library(
            name: "Byte Standard Library Integration",
            targets: ["Byte Standard Library Integration"]
        ),
        .library(
            name: "Byte Test Support",
            targets: ["Byte Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-carrier.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-bit.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Byte Primitive",
            dependencies: []
        ),
        .target(
            name: "Byte Protocol",
            dependencies: [
                "Byte Primitive",
                .product(name: "Carrier", package: "swift-carrier"),
            ]
        ),
        .target(
            name: "Byte Borrowed",
            dependencies: [
                "Byte Protocol",
                .product(name: "Ownership", package: "swift-ownership"),
            ]
        ),
        .target(
            name: "Byte Tagged",
            dependencies: [
                "Byte Protocol",
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Byte Bit",
            dependencies: [
                "Byte Primitive",
                .product(name: "Bit Primitive", package: "swift-bit"),
                .product(name: "Bit Pattern", package: "swift-bit"),
            ]
        ),
        .target(
            name: "Byte",
            dependencies: [
                "Byte Primitive",
                "Byte Protocol",
                "Byte Borrowed",
                "Byte Tagged",
            ]
        ),
        .target(
            name: "Byte Standard Library Integration",
            dependencies: [
                "Byte",
                .product(
                    name: "Carrier Standard Library Integration",
                    package: "swift-carrier"
                ),
            ]
        ),
        .target(
            name: "Byte Test Support",
            dependencies: [
                "Byte",
                "Byte Standard Library Integration",
                .product(
                    name: "Ownership Test Support",
                    package: "swift-ownership"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Byte Tests",
            dependencies: [
                "Byte",
                "Byte Test Support",
            ]
        ),
        .testTarget(
            name: "Byte Standard Library Integration Tests",
            dependencies: [
                "Byte",
                "Byte Standard Library Integration",
                "Byte Test Support",
            ]
        ),
        .testTarget(
            name: "Byte Bit Tests",
            dependencies: [
                "Byte Bit",
                "Byte Test Support",
                .product(name: "Bit Primitive", package: "swift-bit"),
                .product(name: "Bit Pattern", package: "swift-bit"),
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
