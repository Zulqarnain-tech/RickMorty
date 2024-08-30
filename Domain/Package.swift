// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]),
        .library(
            name: "DomainMock",
            targets: ["DomainMock"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Domain",
            dependencies: []),
        .target(
            name: "DomainMock",
            dependencies: ["Domain"]),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain", "DomainMock"]),
    ]
)
