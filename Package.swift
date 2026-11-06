// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CGS",
    platforms: [.iOS(.v15)],
    // Binary targets cannot declare dependencies, so these arrays are the only thing that links
    // and embeds each framework. OneReader is listed for linkage only: the release strips its
    // Swift module from the XCFramework, so none of the engine's types resolve in a host build.
    // Removing it here does not hide it - it breaks the link step.
    products: [
        .library(name: "CGSUI", targets: ["CGSUI", "CGSReader", "CGSData", "OneReader"]),
        .library(name: "CGSReader", targets: ["CGSReader", "CGSData", "OneReader"])
    ],
    targets: [
        .binaryTarget(
            name: "CGSUI",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.2.0/CGSUI.xcframework.zip",
            checksum: "3a93b55a1e62063c33cf6affd7b697ca43ee677b413d825581520de2d3abfba7"
        ),
        .binaryTarget(
            name: "CGSReader",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.2.0/CGSReader.xcframework.zip",
            checksum: "44734e2db6b859898a19fd299a638d30ca7b2bf9d3accdd07ab823175c425f16"
        ),
        .binaryTarget(
            name: "CGSData",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.2.0/CGSData.xcframework.zip",
            checksum: "cb6556678c23821b622dff50b960cce43871fe81395f2d741873cff0fc8cd5ff"
        ),
        .binaryTarget(
            name: "OneReader",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.2.0/OneReader.xcframework.zip",
            checksum: "f4968d342c4593afed079f9717919b20b030c17d065b3ffaa4ee35a8a15068da"
        )
    ]
)
