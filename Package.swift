// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CGS",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "CGSUI", targets: ["CGSUI", "CGSReader", "CGSData", "OneReader"]),
        .library(name: "CGSReader", targets: ["CGSReader", "CGSData", "OneReader"])
    ],
    targets: [
        .binaryTarget(
            name: "CGSUI",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.1.0/CGSUI.xcframework.zip",
            checksum: "01f53d64c308fb815dcf715073337a063b88d6b5a24a6ebfa6718fcaabfc12f3"
        ),
        .binaryTarget(
            name: "CGSReader",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.1.0/CGSReader.xcframework.zip",
            checksum: "4e990e487b36788a3b7865cc110d704a74cf1b4f0081a8d5dff0c89705cc4389"
        ),
        .binaryTarget(
            name: "CGSData",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.1.0/CGSData.xcframework.zip",
            checksum: "41f3795f16d9af2db39a716b8ab5d17cc9aa14f128c524061fc06bf80ade4d46"
        ),
        .binaryTarget(
            name: "OneReader",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.1.0/OneReader.xcframework.zip",
            checksum: "73a433223a0fdea7dd0891e94dc60623218e384759c3664cc5389a3eccb1ab06"
        )
    ]
)
