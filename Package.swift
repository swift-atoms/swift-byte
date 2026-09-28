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
        .library(name: "Byte", targets: ["Byte"]),

        .library(name: "Byte Foundation Integration", targets: ["Byte Foundation Integration"]),
        .library(name: "Byte Test Support", targets: ["Byte Test Support"]),
        .library(name: "Byte Collection Test Support", targets: ["Byte Collection Test Support"]),
    ],
    traits: [
        .trait(name: "BitPattern", description: "BitPattern integration"),

        .trait(name: "Ownership", description: "Borrowed byte access through a read-only span"),
        .trait(name: "Collection", description: "Absorbed Collection integration"),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-bit-pattern.git", branch: "main"),

        .package(url: "https://github.com/swift-atoms/swift-ownership.git", branch: "main"),

        .package(url: "https://github.com/swift-atoms/swift-carrier.git", branch: "main"),
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
            branch: "main", traits: ["Tagged"]
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-atoms/swift-collection.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-iterator.git", branch: "main"),
    ],
    targets: [
        .testTarget(name: "Decision Byte Bit Tests", dependencies: [.target(name: "Byte"), .product(name: "Bit", package: "swift-bit"), .product(name: "Bit Pattern", package: "swift-bit-pattern", condition: .when(traits: ["BitPattern"]))], path: "Tests/Decision Byte Bit Tests"),

        .target(
            name: "Byte",
            dependencies: [
                .product(name: "Bit Pattern", package: "swift-bit-pattern", condition: .when(traits: ["BitPattern"])),

                .product(name: "Ownership", package: "swift-ownership", condition: .when(traits: ["Ownership"])),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Bit", package: "swift-bit"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Finite", package: "swift-finite"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Collection", package: "swift-collection", condition: .when(traits: ["Collection"])),
            ],
            path: "Sources/Byte"
        ),

        .target(
            name: "Byte Foundation Integration",
            dependencies: [
                .target(name: "Byte"),
            ],
            path: "Sources/Byte Foundation Integration"
        ),
        .target(
            name: "Byte Test Support",
            dependencies: [
                .target(name: "Byte"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Byte Tests",
            dependencies: [
                .target(name: "Byte"),
                .product(name: "Bit", package: "swift-bit"),
                .target(name: "Byte Test Support"),
                .target(name: "Byte Foundation Integration"),
            ],
            path: "Tests/Byte Tests"
        ),
        .testTarget(
            name: "Consolidated Byte Carrier Tests",
            dependencies: [
.target(name: "Byte"), .product(name: "Carrier", package: "swift-carrier")],
            path: "Tests/Consolidated swift-byte-carrier"
        ),
        .testTarget(name: "Absorbed swift-byte-collection Byte Collection Tests", dependencies: [.target(name: "Byte"), .target(name: "Byte Collection Test Support"), .product(name: "Carrier", package: "swift-carrier", condition: .when(traits: ["Collection"])), .product(name: "Collection", package: "swift-collection", condition: .when(traits: ["Collection"])), .product(name: "Iterator", package: "swift-iterator", condition: .when(traits: ["Collection"]))], path: "Tests/Absorbed/swift-byte-collection/Byte Collection Tests"),
        .target(name: "Byte Collection Test Support", dependencies: [.target(name: "Byte"), .product(name: "Carrier", package: "swift-carrier", condition: .when(traits: ["Collection"]))], path: "Tests/Absorbed/swift-byte-collection/Support"),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
