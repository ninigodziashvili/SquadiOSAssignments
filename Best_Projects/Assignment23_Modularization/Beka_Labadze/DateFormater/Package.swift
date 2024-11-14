// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DateFormater",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "DateFormater",
            targets: ["DateFormater"]),
    ],
    targets: [
        .target(
            name: "DateFormater"),

    ]
)
