// swift-tools-version: 5.9
import PackageDescription


let package = Package(
    name: "LocalPersistance",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "LocalPersistance",
            targets: ["LocalPersistance"]),
        .library(
            name: "LocalPersistanceMock",
            targets: ["LocalPersistanceMock"]),
    ],
    dependencies: [
        .package(path: "../Domain") // Add Domain as a dependency
    ],
    targets: [
        .target(
            name: "LocalPersistance",
            dependencies: ["Domain"] // Add Domain as a dependency
        ),
        .target(
            name: "LocalPersistanceMock",
            dependencies: ["LocalPersistance", "Domain"] // Add dependencies here
        ),
        .testTarget(
            name: "LocalPersistanceTests",
            dependencies: ["LocalPersistance", "LocalPersistanceMock", "Domain"]), // Add dependencies here
    ]
)



/*
// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalPersistance",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LocalPersistance",
            targets: ["LocalPersistance"]),
        .library(
            name: "LocalPersistanceMock",
            targets: ["LocalPersistanceMock"]),
    ],
    dependencies: [
        // Remove KeychainWrapper dependency
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LocalPersistance",
            dependencies: [] // No dependencies
        ),
        .target(
            name: "LocalPersistanceMock",
            dependencies: ["LocalPersistance"]),
        .testTarget(
            name: "LocalPersistanceTests",
            dependencies: ["LocalPersistance"]),
    ]
)
*/
