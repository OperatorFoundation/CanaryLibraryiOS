// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CanaryLibraryiOS",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CanaryLibraryiOS",
            targets: ["CanaryLibraryiOS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
        //.package(url: "https://github.com/OperatorFoundation/ReplicantSwiftClient.git", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/ShadowSwift.git", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/swift-netutils.git", from: "4.3.0"),
    ],
    targets: [
        .target(
            name: "CanaryLibraryiOS",
            dependencies: [
                //"ReplicantSwiftClient",
                "ShadowSwift",
                .product(name: "Logging", package: "swift-log"),
                .product(name: "NetUtils", package: "swift-netutils")
            ]),
        .testTarget(
            name: "CanaryLibraryiOSTests",
            dependencies: ["CanaryLibraryiOS"]),
    ],
    swiftLanguageVersions: [.v5]
)
