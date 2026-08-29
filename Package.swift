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
            url: "https://github.com/swift-atoms/swift-carrier.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ownership.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-bit.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Byte",
            dependencies: []
        ),
        .target(
            name: "Byte Protocol",
            dependencies: [
                .target(name: "Byte"),
                .product(name: "Carrier", package: "swift-carrier"),
            ]
        ),
        .target(
            name: "Byte Borrowed",
            dependencies: [
                .target(name: "Byte Protocol"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
                .product(name: "Ownership Borrow", package: "swift-ownership"),
            ]
        ),
        .target(
            name: "Byte Tagged",
            dependencies: [
                .target(name: "Byte Protocol"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Byte Bit",
            dependencies: [
                .target(name: "Byte"),
                .product(name: "Bit", package: "swift-bit"),
                .product(name: "Bit Pattern", package: "swift-bit"),
            ]
        ),
        .target(
            name: "Byte Standard Library Integration",
            dependencies: [
                .target(name: "Byte"),
                .target(name: "Byte Protocol"),
                .product(
                    name: "Carrier Standard Library Integration",
                    package: "swift-carrier"
                ),
            ]
        ),
        .target(
            name: "Byte Test Support",
            dependencies: [
                .target(name: "Byte"),
                .target(name: "Byte Standard Library Integration"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Byte Tests",
            dependencies: [
                .target(name: "Byte"),
                .target(name: "Byte Protocol"),
                .target(name: "Byte Tagged"),
                .target(name: "Byte Test Support"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
            ]
        ),
        .testTarget(
            name: "Byte Standard Library Integration Tests",
            dependencies: [
                .target(name: "Byte"),
                .target(name: "Byte Protocol"),
                .target(name: "Byte Standard Library Integration"),
                .target(name: "Byte Test Support"),
            ]
        ),
        .testTarget(
            name: "Byte Bit Tests",
            dependencies: [
                .target(name: "Byte Bit"),
                .target(name: "Byte Protocol"),
                .target(name: "Byte Test Support"),
                .product(name: "Bit", package: "swift-bit"),
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
