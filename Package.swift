// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CafeynSDK",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "CafeynSDK",targets: ["CafeynSDK", "CGSCommon", "OneReader"]),
        .library(name: "CGSCommon",targets: ["CGSCommon", "OneReader"])
    ],
    targets: [
        .binaryTarget(
            name: "CafeynSDK",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.0.5/CafeynSDK.xcframework.zip",
            checksum: "b868ea0058d46b192df47642d4582dd4a81c679f806174fe6880f9e6141816d6"
        ),
        .binaryTarget(
            name: "CGSCommon",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.0.5/CGSCommon.xcframework.zip",
            checksum: "936091effb91a21d70f53b14cb2d2d9a8ea546e2cd2d48e5712aa4b96929b636"
        ),
        .binaryTarget(
            name: "OneReader",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.0.5/OneReader.xcframework.zip",
            checksum: "adc48ae631f25e49faf18cd7d03255a2ffeacf54b83122a8f68b18c20f87fb4d"
        )
    ]
)
