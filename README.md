# CGS iOS SDK

Cafeyn Group Services for iOS: read-and-browse press content — publications, issues, articles and
videos — as a set of SwiftUI screens and components you drop into your own app, backed by Cafeyn's
content infrastructure.

**📚 [API documentation](https://lekiosquefr.github.io/ios-cgs-sdk/)**

> **Distribution is not open yet.** This repository is private, so the XCFramework downloads below
> need access to it. The documentation site is public. If you are evaluating the SDK, talk to your
> Cafeyn contact — they issue the licence key and arrange access.

## Requirements

| | Minimum |
|---|---|
| iOS | 15.0 |
| Xcode | 15.2 |
| Swift | 5.9 (the SDK compiles in Swift 6 strict-concurrency mode internally; your app may use either language mode) |

## Installation

Swift Package Manager. In Xcode, *File → Add Package Dependencies…* and enter the repository URL, or
add it to your own `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/LeKiosqueFr/ios-cgs-sdk.git", from: "0.1.0")
]
```

Two products:

- **`CGSUI`** — the SwiftUI screens and components. This is what most apps want.
- **`CGSReader`** — the PDF and article reader without the rest of the UI layer.

Both ship as pre-compiled XCFrameworks attached to the release, so there is no source to build.

## Quickstart

Initialize the SDK once at launch, before anything else touches it:

```swift
import CGSUI
import SwiftUI
import UIKit

@main
struct MyApp: App {
    init() {
        do {
            try CGS.initialize(
                licenceKey: "<your licence key>",
                configuration: .init(
                    environment: .production,
                    product: "<your product identifier>"
                )
            )
        } catch {
            // `CGS.Error.Init` — an invalid licence key, or a second call.
            assertionFailure("CGS failed to initialize: \(error)")
        }

        // Optional: tint the SDK's surfaces with your brand. Everything else keeps its
        // default token. Pass `.complete(_:)` instead if you own the whole design.
        CGS.UI.setTheme(.branded(brand: .systemIndigo, accent: .systemPink))
    }

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

The licence key and the product identifier both come from your Cafeyn contact.

Screens are then placed like any other SwiftUI view — for example, the reader's downloaded issues:

```swift
CGS.UI.libraryPage(
    sources: .init(issues: issues, imageResolver: resolver),
    actions: .init(onSelectIssue: { issue in /* open the reader */ })
)
```

Each screen documents its inputs, its actions and what it deliberately leaves to the host. Start
from the [documentation site](https://lekiosquefr.github.io/ios-cgs-sdk/) — `CGSUI` for the
screens, `CGSData` for the models and errors they hand back.

## Support

Contact your Cafeyn representative. Please include the SDK version you are on, taken from the tag
you resolved.

<!-- From 0.1.1 on, this file is rendered by the ios-cgs SDK-Release workflow from Scripts/README-template.md. Do not edit it here. -->
