// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Arena",
    products: [
        .executable(name: "arena", targets: ["ArenaCLI"]),
        .library(name: "ArenaCore", targets: ["ArenaCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/apple/swift-package-manager", from: "0.5.0"),
        .package(url: "https://github.com/finestructure/Parser", from: "0.0.0"),
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0"),
        .package(url: "https://github.com/mxcl/Path.swift.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ArenaCLI",
            dependencies: ["ArenaCore"]),
        .target(
            name: "ArenaCore",
            dependencies: ["ArgumentParser", "Parser", "Path", "ShellOut", "SwiftPM-auto"]),
        .testTarget(
            name: "ArenaTests",
            dependencies: ["ArenaCore"]),
    ]
)
