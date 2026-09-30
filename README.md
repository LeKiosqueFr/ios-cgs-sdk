<!-- Generated from Scripts/README-template.md in LeKiosqueiOS/CGS. Do not edit here: the next release overwrites it. -->

# CGS SDK for iOS

Content SDK for the Cafeyn group: publications, issues and articles, with offline downloads, a PDF
and article reader, and a set of ready-made screens you can add to your own app.

Full API reference: **[CGSUI](https://lekiosquefr.github.io/ios-cgs-sdk/documentation/cgsui)** ·
[CGSReader](https://lekiosquefr.github.io/ios-cgs-sdk/documentation/cgsreader) ·
[CGSData](https://lekiosquefr.github.io/ios-cgs-sdk/documentation/cgsdata). This page is the path
from an empty app to an issue open in the reader. Everything outside this path is a link.

> **Alpha — `0.x`.** The public API is not stable. Any `0.x` release may remove, rename or reshape
> public symbols, with no deprecation warning beforehand and no change of major version to signal
> it. **Pin an exact version** — `exact:`, never `from:`. SwiftPM reads `from: "0.1.0"` as
> `0.1.0..<1.0.0`, with no special case for `0.x`, so it would resolve straight through every
> breaking alpha release. The surface freezes at `1.0.0`.

## Requirements

| | |
|---|---|
| Deployment target | iOS 15 |
| Toolchain | **Xcode 16 or later** |

The frameworks include `.swiftinterface` files built with `-swift-version 6`, and the surface uses
typed `throws`. Your own app can stay in Swift 5 language mode — but the compiler that reads our
interfaces has to understand Swift 6 syntax, so Xcode 15 cannot load these modules at all.

**Your app needs keychain access.** The SDK stores the session in the keychain, so the target must
be signed and carry a `keychain-access-groups` entitlement. Without it the first `authenticate`
call fails with an `OSStatus` of `-34018` (`errSecMissingEntitlement`) — which is a signing
problem, not a credentials problem.

## Install

Swift Package Manager. In Xcode, *File → Add Package Dependencies…*, or in a `Package.swift`:

```swift
.package(url: "https://github.com/LeKiosqueFr/ios-cgs-sdk.git", exact: "0.1.1")
```

Two products, both using pre-compiled XCFrameworks:

| Product | Take it when |
|---|---|
| **`CGSUI`** | you want the ready-made screens and the theme. Includes `CGSReader`. **Start here.** |
| `CGSReader` | you build every screen yourself and need only the data layer plus the reader |

The rest of this page assumes `CGSUI`.

## Getting started

### 1. Initialize, once, at launch

```swift
try CGS.initialize(
    licenceKey: "your-licence-key",
    configuration: .init(
        environment: .production,
        selectsProfileAutomatically: true
    )
)
```

One `import CGSUI` brings in the reader and the data layer with it.

Call it before anything else the SDK offers: every other capability reports a call made too early on
its own error type, as `.sdk(.notInitialized)`. A second `initialize` throws
`CGS.Error.Init.alreadyInitialized`.
`environment` is a `CGS.Environment` — `.production`, `.preproduction` or `.dev`.
`selectsProfileAutomatically: true` is for an app with no user profiles; step 3 explains both
choices. This setting is temporary: it will move to your point-of-sale configuration.

Your licence key comes from your Cafeyn contact. **The key is bound
to your bundle identifier, not to a platform**: the same key works on iOS and Android for an app
published under the same identifier, and a key issued for a different identifier throws
`CGS.Error.Init.licence(.bundleMismatch)`.

### 2. Theme

The SDK draws itself from one theme. Set it **before the first CGS view appears** — views read the
active theme when their body is evaluated, and changing it afterwards does not re-render what is
already on screen.

```swift
CGS.UI.setTheme(.branded(brand: brandColor, accent: accentColor))
```

Two brand colors are usually enough: `.branded(brand:accent:)` tints the brand surfaces, text and
icons, and leaves every other token at its default. For full control, build a
`CGS.UI.Theme` and pass `.complete(_:)`. To change one thing and keep the rest, start from what is
already applied:

```swift
var theme = CGS.UI.currentTheme
theme.cornerRadiuses.medium = 4
CGS.UI.setTheme(.complete(theme))
```

`setTheme` also styles both readers. If you want the reader to differ from the rest of the SDK,
call `CGS.Reader.setAppearance(_:)` **after** `setTheme`: the last call replaces the previous one.
It applies to readers presented after it, not to one already on screen.

The SDK includes no typeface. `Theme.typographies` carries sizes, weights and line heights; the
families resolve against fonts your app registers.

### 3. Authenticate

The SDK never logs anyone in. You own identity: you authenticate the user against your own
backend, and hand the SDK the resulting token.

```swift
try await CGS.Data.Auth.authenticate(method: .token(tokenFromYourBackend))
```

Which profile is active after that depends on `selectsProfileAutomatically` (step 1):

- **`true`** — for an app with no user profiles. The SDK activates the account's default profile on
  every authentication, and you never name one.
- **`false`**, the default — for an app that manages profiles. The SDK never picks one. Read the
  account's profiles from the session, and activate one yourself:

```swift
for await session in CGS.Data.Auth.session.values
    where session.kind.isAuthenticated && session.kind.profileId == nil {
    let profile = await profileChosenByYourUser(among: session.kind.profiles)
    try await CGS.Data.Auth.setProfileId(profile.identifier)
}
```

Pass one of `session.kind.profiles`. The SDK does not check the identifier, and the backend rejects
every request that carries an unknown one.

Until a profile is active, every profile-scoped provider reports `.failed(.profileNotSet, …)` and
downloads are hidden. The SDK saves your choice with the session. `logout()` or an expired session
clears it, so choose again after the next `authenticate`.

Downloads belong to the active profile. They survive a relaunch, but a reinstall deletes them with
the app.

The current session is a publisher, and the SDK tells you when the backend ends one:

```swift
for await session in CGS.Data.Auth.session.values {
    print("authenticated:", session.kind.isAuthenticated)
}

// Called on the main actor when the back-end invalidates the session. Supply a fresh token.
CGS.Data.Auth.onSessionExpired = { reason in
    print("session ended:", reason)
}
```

`session.kind` tells you whether anyone is authenticated, which profiles the account has, and which
one is active.
`CGS.Data.Auth.logout()` ends the session, and `setProfileId(_:)` switches profile without
re-authenticating.

### 4. Show a screen

**A library page** — the issues this profile has finished downloading, as a grid, with an empty
state when nothing is on disk:

```swift
CGS.UI.libraryPage(
    actions: .init(onSelectIssue: { issue in
        // The page calls this instead of opening the reader. Step 6 opens it.
        print("selected", issue.identifier.rawValue)
    })
)
```

Pass a `selection` binding to switch it into multi-select mode; deleting the selected downloads,
and the button that does it, stay yours.

**A publication page** — one issue's cover, summary, supplements and archives:

```swift
CGS.UI.publicationPage(
    .issue(issueIdentifier),
    actions: .init(
        onSelectArticle: { article in print("article", article.article.identifier.rawValue) },
        onSeeAllArticles: { issueId in print("all articles of", issueId.rawValue) },
        onSeeAllArchives: { publicationId in print("archives of", publicationId.rawValue) }
    )
)
```

Tapping an *issue* is not among those actions: the featured issue opens in the reader by itself,
and a supplement or an archive replaces the content of the page. Use `.publication(_:)` instead of
`.issue(_:)` to open on whichever issue is the latest when the page loads.

**Lists of content** come from `CGS.UI.lazyList(issues:…)` and its siblings. Its `configuration`
parameter defaults to a **horizontal carousel** — if you want a scrollable grid, ask for one:
`configuration: .grid()`. `.list()` and `.carousel(_:)` are the other two.

### 5. Download an issue

`CGS.Data.Downloads.issue(_:)` returns a live handle. The same identifier always returns the same
instance, so it is safe in a `@StateObject`:

```swift
struct IssueDownloadButton: View {

    @StateObject private var download = CGS.Data.Downloads.issue(issueIdentifier)

    var body: some View {
        switch self.download.state {
        case .notDownloaded:
            Button("Download") { Task { try await self.download.start() } }
        case .queued, .downloading:
            ProgressView(value: self.download.progress)
            Button("Pause") { Task { await self.download.pause() } }
        case .paused:
            Button("Resume") { Task { try await self.download.resume() } }
        case .downloaded:
            Button("Delete") { Task { try await self.download.delete() } }
        case .failed(let error):
            Text(error.localizedDescription)
        default:
            EmptyView()
        }
    }
}
```

The `default` is there because `Item.State` is a plain `public enum` today: a switch listing every case
still does not satisfy the Swift 6 language mode. That is being settled — until it is, keep the `default`.

`state` and `progress` are `@Published`. `start`, `pause`, `resume`, `cancel` and
`delete` live on the handle; `pauseAll()`, `resumeAll()` and `wipeAllUserData()` live on
`CGS.Data.Downloads`.

Once at launch, resume the downloads that a process kill or a reboot interrupted:

```swift
Task { await CGS.Data.Downloads.resumeAll() }
```

**To keep downloading while your app is in the background**, opt in once at launch — before any
download starts, because the session cannot be reconfigured afterwards:

```swift
CGS.Data.Downloads.enableBackgroundSession(identifier: "com.yourcompany.yourapp.cgs")
```

…and forward the system's callback to the SDK:

```swift
func application(
    _ application: UIApplication,
    handleEventsForBackgroundURLSession identifier: String,
    completionHandler: @escaping () -> Void
) {
    CGS.Data.Downloads.handleBackgroundEvents(
        forSession: identifier,
        completionHandler: completionHandler
    )
}
```

Both are needed, and so is the **Background Modes** capability in your target. If one is missing,
downloads stop when the app is suspended, with no error.

**Two ways to list downloads, and they are not the same list.**
`CGS.Data.Downloads.all.items` is every download in any state — queued, running, paused, failed —
as live handles, account-wide. `CGS.Data.Content.downloadedIssues()` is a provider over the
*finished* ones as catalog models, scoped to the active profile, reloading itself as downloads
complete or are deleted. `CGS.UI.libraryPage` renders the second.

### 6. Open the reader

```swift
CGS.Reader.open(issueId: issueIdentifier, from: presenter)
```

**A prior download is not required.** The reader resolves the issue's layout live and fetches pages
as they are reached; a downloaded issue simply opens with no network. `CGS.Reader.open(articleId:issueId:from:)`
opens a single article the same way.

Both take a `UIViewController` to present from, and **the SDK does not give you one** — a SwiftUI
app has to find its own. This is the helper our sample app uses. You own this code; it is not part of
the SDK:

```swift
@MainActor
func topMostViewController() -> UIViewController? {
    let keyWindow = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
    var top = keyWindow?.rootViewController
    while let presented = top?.presentedViewController {
        top = presented
    }
    return top
}
```

`CGS.UI.publicationPage` needs none of this — it finds a presenter itself and opens the reader from
its own cover. Only `libraryPage`, and your own lists, call back to you.

### 7. Handle errors

Every failure you can act on is a typed `throws`, one type per capability: `CGS.Error.Init`,
`CGS.Error.Auth`, `CGS.Error.Content` and `CGS.Error.Downloads`. Inside a `catch` the error is
already that type — nothing to cast, and nothing from a lower layer reaches you unwrapped.

```swift
do {
    try await CGS.Data.Auth.authenticate(method: .token(tokenFromYourBackend))
} catch {
    switch error {
    case .invalidCredentials, .tokenExpired:
        print("issue a fresh token and call authenticate again")
    case .licence(let licence):
        print("licence rejected:", licence)
    case .network:
        print("offline - the SDK will not have written a session")
    default:
        print(error.localizedDescription)
    }
}
```

## What the SDK leaves to you

Deliberately outside the SDK. Plan for these before you start.

- **Identity.** Signing in, storing credentials and refreshing your own token. The SDK takes a
  token and nothing else. If your app manages profiles, the profile picker is yours too (step 3).
- **A presenting view controller** for the reader (step 6).
- **A reading list.** There is no bookmark or favourites store. You persist the identifiers and
  reload the issues yourself.
- **Reading progress.** The SDK does not compute it. Note that some cells can *draw* a progress
  ring, so a design that shows one needs a value the API cannot produce today. Plan for that.
- **Locale.** `CGSUI` includes `de`, `en`, `en-CA`, `es`, `fr`, `it` and `nl`, and follows the system
  language. Overriding it per-user is yours.
- **Knowing an issue is locked before the tap.** Reading rights are reported as an error when the reader
  opens, not as a state you can read off the catalog beforehand.

## Support

This page describes **`0.1.1`**. It is generated at release time, so it always matches the tag it is
released with.

Questions, a licence key, or a bug: your Cafeyn contact.
