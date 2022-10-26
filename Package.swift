// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CanaryLibraryiOS",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CanaryLibraryiOS",
            targets: ["CanaryLibraryiOS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
        .package(url: "https://github.com/OperatorFoundation/ReplicantSwift.git", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/ShadowSwift.git", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/swift-netutils.git", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Starbridge.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CanaryLibraryiOS",
            dependencies: [
                "ReplicantSwift",
                "ShadowSwift",
                "Starbridge",
                .product(name: "Logging", package: "swift-log"),
                .product(name: "NetUtils", package: "swift-netutils")
            ]),
        .testTarget(
            name: "CanaryLibraryiOSTests",
            dependencies: ["CanaryLibraryiOS"]),
    ],
    swiftLanguageVersions: [.v5]
)
