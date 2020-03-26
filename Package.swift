// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LLDialog",
    platforms: [.iOS(.v8), .tvOS(.v9)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "LLDialog",
            targets: ["LLDialog"]),
        .library(
            name: "LLDialogDYLIB",
            type: .dynamic,
            targets: ["LLDialog"]),
    ],
    targets: [
        .target(
            name: "LLDialog",
            dependencies: [],
            path: "Source"),
    ]
)
