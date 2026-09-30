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
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.1.1/CGSUI.xcframework.zip",
            checksum: "78539cb0f239c3df44ed3dcb8012bc5483db369f53a8ca9fdd8545c996e6fcf0"
        ),
        .binaryTarget(
            name: "CGSReader",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.1.1/CGSReader.xcframework.zip",
            checksum: "08caf3a465cf4479c484cdde346f50899d138d3c686bd1c20dd7485f7ee2987b"
        ),
        .binaryTarget(
            name: "CGSData",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.1.1/CGSData.xcframework.zip",
            checksum: "7fafb5199d368d8530bb2859854228974f3d0f1ffd4ba86c965277cc8dd917e6"
        ),
        .binaryTarget(
            name: "OneReader",
            url: "https://github.com/LeKiosqueFr/ios-cgs-sdk/releases/download/0.1.1/OneReader.xcframework.zip",
            checksum: "ddd3ea3965d19965f14a61f6ded2a673a9962443ef41a9f90e669a833507adf9"
        )
    ]
)
