// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainApp1",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "MainApp1",
            targets: ["MainApp1"]),
    ],
    dependencies: [
        .package(path: "../DateFormater"),
        .package(path: "../Network")
    ],
    targets: [
        .target(
            name: "MainApp1",
            dependencies: [
                .product(name: "DateFormater", package: "DateFormater"),
                .product(name: "Network", package: "Network")
            ]
        ),
    ]
)
