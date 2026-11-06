# Changelog

All notable changes to the CGS iOS SDK are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the SDK follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

**While MAJOR is 0, the public API is not stable.** Any `0.x` release may remove, rename or reshape public symbols, with no MAJOR bump and no deprecation cycle first — SemVer's [initial development clause](https://semver.org/#spec-item-4). The section below is your migration document; read it before upgrading. Entries are assembled at release time rather than per pull request, so `Unreleased` can lag the tip of `main`.

From `1.0.0` on the surface is locked, and the usual bumps apply:

- **Patch** (`X.Y.Z+1`): bugfix only. Always safe to upgrade.
- **Minor** (`X.Y+1.0`): API additions, deprecations. Never removals or signature changes. Safe to upgrade with at most a few deprecation warnings.
- **Major** (`X+1.0.0`): removals, refactors, iOS minimum bump. Migration may require code changes. Ships with a `MIGRATING_FROM_X_TO_Y.md` document.

Releases are tagged `MAJOR.MINOR.PATCH` (e.g. `1.2.3`). The same value is reflected in `Sources/CGSData/Internal/CGSVersion.swift` and sent in the `sdkVersion` header of every backend request.

Each entry uses these buckets when applicable:
- **Added** for new features.
- **Changed** for changes in existing functionality.
- **Deprecated** for soon-to-be removed features.
- **Removed** for now removed features.
- **Fixed** for any bug fixes.
- **Security** for vulnerabilities and disclosed CVEs.

## [Unreleased]

## [0.2.0] - 2026-11-06

### Added

- `CGS.Data.Media`: a media as an ordered list of pages, loaded by `CGS.Data.Content.Media`. Each `Media.Page` has a title (`CGS.Data.I18nString`) and a `Page.Content`: a publication, a skeleton (`CGS.Data.Skeleton.Identifier`) or a feed (`CGS.Data.Feed.Identifier`). Show one page full screen, or several pages as tabs.
- `CGS.UI.mediaPage(_:configuration:actions:)` draws one page of a media from its content. `CGS.UI.MediaPage.Actions` receives the taps.
- `CGS.UI.pager(pages:selection:title:configuration:content:)` shows every page of a media on one screen, with one pill per page. The reader taps a pill or swipes, and the host keeps the selection. Colors come from `CGS.UI.Pager.UIConfiguration`.
- `CGS.UI.sectionPage(skeleton:configuration:actions:)` builds a page block by block from a skeleton sent by the backend, and loads more blocks as the reader scrolls. A block header can show a title and a chevron.
- `CGS.UI.Destination`: the page a block header's chevron opens. It reaches the host in `SectionPage.Actions.onDestination`, and `CGS.UI.sectionPage(sections:configuration:actions:)` draws its sections.
- `CGS.UI.SectionPage.Actions` and `CGS.UI.MediaPage.Actions` give each tap a `CGS.Data.Skeleton.ItemContext`: the block, its rank on the page and the rank of the item.
- Pull to refresh: `CGS.Data.ReloadableContent.refresh()` loads a provider again from the network and keeps the loaded items on screen during the reload. `CGS.UI.SectionPage.UIConfiguration.isRefreshable` turns it on for a page.
- `CGS.UI.EmptyState`, the Blend empty and error view, and an `emptyView:` parameter on `CGS.UI.sectionPage(children:configuration:emptyView:)`. A page of sections hides an empty section. A failed block or page shows `EmptyState` with a Retry button, and a page with no active profile shows it with no Retry.
- Account rights: `CGS.Data.Profile.rights` publishes the rights of the active profile. `nil` means the SDK does not know them yet, not that there are none: do not draw a lock from it. The value is `Rights.empty` without a session or an active profile. `Rights.canRead(_:)` tells whether an issue is readable. The SDK loads the rights again when the backend reports a newer version.
- Checkout through the host: `CGS.Data.Purchase.setCheckoutHandler(_:)` registers the closure that runs a purchase. It receives a `CheckoutRequest` (the `Content`, its `Origin` and the `Offer`) and returns an `Outcome`. The SDK loads the rights again after a purchase.
- Buy button: `CGS.UI.Purchase.setBuyButtonHandler(_:)` lets the host give the title of a Buy button (`BuyButton`) for content the reader cannot read. The publication page shows it at `Placement.publicationPage`, and a tap starts the checkout. No handler, or no offer, shows no button. **In 0.2.0 the offers are a placeholder**: only one sandbox publication of `CGSSample` has an offer, so no other content shows a Buy button until the backend offers route is connected.
- `CGS.UI.Purchase.present(style:_:)` shows the host's paywall over the SDK screen on display, as a `.sheet` or `.fullScreen` (`PresentationStyle`), and returns the `Outcome` the paywall passes to its `Dismiss` closure.
- Host wordings: `CGS.Localization.setOverrides(_:)` replaces SDK texts key by key, from a `CGS.strings` file per language (`Overrides.bundle(_:table:)`) or from a lookup closure (`Overrides.provider(_:)`). `CGS.Localization.Language` lists the six languages the SDK ships. Each release publishes `WORDINGS.md`, the list of keys, next to the binaries.
- `CGS.Data.Tracking.Event.onBlockItemClicked(_:)`: one event per tap on an item of a skeleton block, with the item and its `ItemContext`.
- Components: `CGS.UI.TextField`, `CGS.UI.PasswordField`, `CGS.UI.RadioButton` and `CGS.UI.SegmentedControl`, from Blend.
- Cards: `CGS.UI.Issue.Rich` (a full-width issue row), `CGS.UI.Issue.Brand` (a cover with the title in a brand bar), `ArticleTimelineCellView` (the time, then the title) and `PublicationTileView` (a publication logo). Each one has a `shimmer()`.
- `CGS.UI.Section.ArticlesLayout` (`.standard`, `.timeline`), passed to the new `layout:` parameter of `CGS.UI.section(articles:…)`, and `PublicationsLayout.tile` for a rail of publication logos.
- `ArticleCardView.UIConfiguration.outlined`: a 1 pt border, for a card placed on the page background.
- `CGS.Data.Publication.logo`.
- `CGS.UI.Theme.Typography.Headline.m` / `.s`, `Body.l.emphasized`, `Label.s.regular` and `Label.l.regular`, backed by five new `Typographies` slots: `headlineMedium`, `headlineSmall`, `bodyLargeEmphasized`, `labelSmallRegular`, `labelLargeRegular`. **Breaking**: the memberwise initialiser gains five parameters, so a host building a typography set by hand has to add them.

### Changed

- **Breaking**: `CGS.UI.LazyList` is now `CGS.UI.Section`, and `CGS.UI.Grid` is now `CGS.UI.SectionPage`. Rename `CGS.UI.lazyList(…)` to `CGS.UI.section(…)`, `CGS.UI.grid(children:configuration:)` to `CGS.UI.sectionPage(children:configuration:emptyView:)`, `Grid.block(id:content:)` to `SectionPage.custom(id:content:)` and `Grid.UIConfiguration` to `SectionPage.UIConfiguration`.
- **Breaking**: the `Section.UIConfiguration` presets change. `.carousel(_:)` becomes `.horizontal(_:)`, `.grid(_:rowSpacing:)` becomes `.vertical(columns: .adaptive(_:), rowSpacing:)` and `.list(maxItems:separator:)` becomes `.vertical(columns: .single(separator:), maxItems:)`. The `carousel` property is now `cellLayout`. `CellLayout.columns` and `ColumnCount` are removed: the number of columns now always follows the available width and `cellWidth`.
- **Breaking**: `CGS.Data.Content.Media` loads a `CGS.Data.Media` (the pages of the media) instead of a `CGS.MediaWithPublications`.
- **Breaking**: `CGS.Error.Downloads` gains a `rightsInsufficient` case, so an exhaustive `switch` over it stops compiling. Starting a download of an issue the active profile may read nothing of fails with it, and nothing is downloaded.
- `CGS.Reader.open(issueId:…)` keeps its signature and still returns at once, but checks the access first. When the saved rights do not show that the active profile may read the whole issue, the SDK asks the backend, so the reader shows a moment later. An issue with a preview opens on its preview pages only, and an issue without one opens nothing. When the backend cannot be reached, the reader opens and shows its own error. From a downloaded preview, `CGS.Reader.open(articleId:…)` reads from disk only the articles printed on the preview pages: any other article is fetched live, and the backend decides.
- An issue open on its preview pages shows the full issue once the account gets the rights to it.
- `CGS.UI.section(issues:…)` draws a lock on every issue the account cannot read, and removes it by itself after a purchase. While the rights are not known yet, no issue shows a lock. With no session or no active profile, every issue shows it.
- The skeleton page blocks follow the `CGSSample` design: serif block titles, bordered article cards with the date and the reading time, and the design's horizontal widths. The publication page follows the same design.
- The Summary and Archives pages take the color of their cells, and their titles use the theme's title family.
- The error state of `CGS.UI.section` is now the Blend `EmptyState`, which is taller than before. `CGS.UI.publicationPage` hides its lists when there is no active profile.

### Fixed

- A pager page on iOS 17 and later scrolls under the tab bar, instead of stopping above it with a blank band.
- A horizontal rail of publication tiles draws 80 pt tiles, 16 pt apart and aligned with the block title, on every iPhone width. Before, the tiles touched each other on the largest iPhones.

## [0.1.1] - 2026-09-30

No entries were kept for this release.

## [0.1.0] - 2026-09-01

### Added

- `CGS.UI.Theme.Spacings` and the `Theme.spacings` field exposing the spacing scale.
- `CGS.UI.Theme.Opacities` and the `Theme.opacities` field exposing the Figma opacity scale — 14 slots (`percent0`, `percent5`, `percent10`, `percent15`, `percent20`, `percent25`, `percent30`, `percent40`, `percent50`, `percent60`, `percent70`, `percent80`, `percent90`, `percent100`), stored as the `0`–`1` fractions SwiftUI expects. `CGS.UI.Theme.Opacity` reads a slot from the active theme. **Breaking**: `Theme.init` gains an `opacities` parameter, so a host building a theme by hand has to add it.
- `CGS.UI.Theme.Typography.Family` / `.Weight` / `.Size` / `.LineHeight` atomic font primitives mirroring the Figma `Mobile.tokens.json` export.
- `CGS.UI.Theme.Typography.Label.{s,m,l}.emphasized` composite tokens for label-heavy views (Badge and future consumers). They read the active theme rather than returning a constant, so overriding the matching `Typographies` slot changes every consumer at once.
- `CGS.UI.Theme.Typographies` gains four Blend slots — `labelSmallEmphasized`, `labelMediumEmphasized`, `labelLargeEmphasized`, `captionRegular` — backing the composites above. **Breaking**: the memberwise initialiser gains four parameters, so a host building a typography set by hand has to add them.
- `CGS.UI.Badge.UIConfiguration.maxLabelWidth` (120 pt) and a truncation contract on Badge: label capped with `.lineLimit(1)` + tail ellipsis, `.accessibilityLabel(state.label)` on the badge root so VoiceOver reads the full string.
- `CGS.UI.Tag` — non-interactive status pill, 3 styles (`brand` / `neutral` / `success`) × 2 sizes (`small` 20 pt / `medium` 24 pt) × 4 content modes. Built like Badge: a `UIState` payload plus a `UIConfiguration` from `.brand(size:)` / `.neutral(size:)` / `.success(size:)` or `.resolve(style:size:)`. Leading and trailing slots take an icon or an inline count badge. Disabled comes from the SwiftUI environment and swaps colour tokens rather than fading.
- `CGS.UI.Chip` — tappable assistive pill, 1 family × 2 sizes (`small` 24 pt / `medium` 32 pt) × 3 content modes (label only, icon before the label, icon after it). Built like Tag: a `UIState` payload plus a `UIConfiguration` from `.assistive(size:)`, with the tap handler passed to `init(state:configuration:action:)`. The icon side is part of the value (`.leading(_:)` / `.trailing(_:)`), so an icon can never sit on both sides. Renders enabled, pressed (a 15 % state layer over the pill and its border) and disabled states; disabled comes from the SwiftUI environment and swaps colour tokens rather than fading. The pill keeps its drawn height while the chip reserves a 44 pt tall hit region, and the whole chip is capped at `UIConfiguration.maxWidth` (160 pt) with a tail ellipsis.
- `ArticleCardView` — the SDK's article cell, in two densities: `standard` (120×80 side image, 1-line preview) and `rich` (full-width 3:2 image, 2-line preview), each crossed with `isLocked` and `isRead`. Takes a `UIState` for content and a `UIConfiguration` for visuals like the other cards, and composes `CGS.UI.Tag`, `CGS.UI.Badge` and `ActionBarView` rather than redrawing them. `isRead` swaps the title from `Title.m.emphasized` to `Title.m.regular`; `isLocked` prepends a `brandAccent` badge. The cover slot keeps its footprint whatever the artwork does — while loading, after a failed load, and when `coverAsset` is `nil` it draws the design's placeholder (a template glyph tinted `foregroundSubtle` over `surfaceTertiary`) instead of collapsing and reflowing the card. Two optional slots complete the design: `selection:` takes a `Binding<CGS.UI.Checkbox.Selection>` and draws a leading `CGS.UI.Checkbox` (`.small`, 16 pt glyph in a 46 pt control) for selectable lists — `nil`, the default, draws none; `chips:` takes `[ArticleCardView.ChipItem]` and lays out `CGS.UI.Chip` assistive pills (`.small`) after the info labels. Both are content-driven rather than modal: passing a checkbox does not suppress the tag, the identity line or the action bar the way the Figma variant does. A row carrying chips grows from 32 pt to the 44 pt touch target `CGS.UI.Chip` guarantees. `standard` gives its title the three lines the design draws: Figma's 100 pt title+preview box assumes a 24 pt line height, but a 22 pt system font sets its own at ≈26.2 and `Typography` can only add leading, never compress, so capping the box cost a line. The card is ~8 pt taller than the mock as a result.
- `CGS.UI.Theme.Typographies` gains three Blend slots — `titleMediumEmphasized` and `titleMediumRegular` (22/24 Medium and Regular, Figma `Text/Title M`), and `labelMediumRegular` (14/16 Regular, Figma `Text/Label M`) — exposed as `Typography.Title.m.emphasized`, `Typography.Title.m.regular` and `Typography.Label.m.regular`. The nearest legacy slots were wrong for the article card: `titleLarge` is 22/32, and `labelMediumEmphasized` is Medium, not Regular. **Breaking**: the memberwise initialiser gains three parameters, so a host building a typography set by hand has to add them.
- `Icon.Status.locked` — glyph of the article card's locked badge.
- `ActionBarView.UIConfiguration.Layout` — button padding, corner radius and inter-button spacing, with a `.default` preset matching today's bare 16 pt glyphs and a `.ghostSmall` preset giving Figma's `Ghost / SM` treatment (16 pt glyph in a 32 pt tap target, buttons flush). `ArticleCardView` uses `.ghostSmall`; every other card keeps `.default`, so their action rows are unchanged. Additive — `UIConfiguration.init` and `ActionButton.init` both default the new parameter.
- `CGS.UI.Theme.Colors.ForegroundColors.disabled` (`#AEAEB2` light / `#BCBCC0` dark) and `CGS.UI.Theme.Colors.ButtonsColors.disabled` (`#D8D8DC` light / `#8E8E93` dark). **Breaking**: both memberwise initialisers gain a parameter, so a host building either colour set by hand has to add it.
- `CGS.UI.Theme.Typography.Caption.regular` — Figma `Text/Caption`, Source Sans 3 Regular 10 pt on a 16 pt line height. Additive.
- `CGS.UI.Badge.Size.twoExtraSmall` — 12 pt tall, zero padding, `Caption.regular` label, no icon support. Design reserves it for the count chip inside `CGS.UI.Tag`. **Breaking**: `Size` is `public` and `CaseIterable`, so exhaustive switches over it downstream stop compiling.
- `CGS.UI.Badge.UIConfiguration.disabled(type:size:cornerRadius:)` — style-independent disabled palette built from `ButtonsColors.disabled` + `ForegroundColors.disabled`, matching how Figma draws a disabled badge. Use it when the surrounding component already signals disabled through its own tokens and a `.disabled(true)` fade would double up.
- The SDK ships **no typeface**. `Typography.Label.*` and `Typography.Caption` render San Francisco at the weight their `weight` primitive declares, resolved through `Typography.resolvedUIFont()`. To match the Figma design, register your own faces — `UIAppFonts` in an app target, or `CTFontManagerRegisterFontsForURL` elsewhere — and point the matching `Typographies` slots at them with `Font.custom(_:)`. An explicit custom face always wins over the system fallback; one that fails to resolve degrades to the system face and logs a warning. `CGSSample` is the reference implementation.

### Changed

- `Spacing` migrates from a 7-step to a 15-step scale matching Figma Blend: `threeXS` (2), `twoXS` (4), `xs` (6), `s` (8), `m` (12), `l` (16), `xl` (20), `twoXL` (24), `threeXL` (32), `fourXL` (40), `fiveXL` (48), `sixXL` (64), `sevenXL` (80), `eightXL` (96), `nineXL` (128). Figma's slot names start with a digit (`3xs`, `2xl`, …); Swift spells them out (`threeXS`, `twoXL`, …) rather than backtick-escaping them. Value shifts: old `.m`=16 becomes `.l`, old `.l`=24 becomes `.twoXL`, old `.xl`=32 becomes `.threeXL`, old `.xxl`=40 becomes `.fourXL`, old `.xxxl`=48 becomes `.fiveXL`. New slots: `.xs`=6, `.sixXL`=64, `.sevenXL`=80, `.eightXL`=96, `.nineXL`=128.
- `CGS.UI.Theme.BrandColors.standard` returns the Blend violet palette (`brand` / `medium` = `#9747FF`, `accent` = `#8FEBDB`, full soft/strong light+dark) instead of the previous tan/gold ramp. Downstream apps that want the previous ramp inject via `.branded(brand: #AE8A51, accent: #D7631B)`.
- `CGS.UI.Badge` retargets to Figma Master `2138:11064`: heights XS 16→20, MD 28→32; the icon glyph is 12 pt at every size, centred in the 16 pt slot Figma reserves for it; icon-label gap unified to `.spacing(.threeXS)` (2 pt); paddings match Figma per-cell; typography uses the `Typography.Label.{s,m,l}.emphasized` composites; filled palette rebound to `buttons*` surfaces with `foregroundEmphasized` (success/warning) or `foregroundNeutral` (neutral/error) foreground.
- `Icon` adopts the Figma canonical taxonomy. The three namespaces `Icon.Navigation` / `Icon.Action` / `Icon.Info` become eleven — `Navigation`, `Operations`, `Status`, `File`, `Controls`, `Toggle`, `Technology`, `Formatting`, `Time`, `User`, `Custom` — and every case is re-homed and renamed to its Figma name (`Icon.Action.check` → `Icon.Status.checkmark`, `Icon.Action.close` → `Icon.Navigation.close`, …). Asset catalog imagesets are renamed to kebab-case to match (`Icons/Status/checkmark.imageset/checkmark.svg`). `Icon.Action` and `Icon.Info` no longer exist: every call site is a compile error until it moves to the new namespace.
- `CGS.UI.Badge` honours the `min-width` Figma authors per size — 12 pt on `.twoExtraSmall`, 28 pt on `.extraSmall`, none on `.small` / `.medium`. Previously a minimum width applied only to icon-only badges, so a short label collapsed to the glyph's own width: a single-digit `2XS` count chip rendered 6.5 pt wide instead of the 12 pt circle the design shows. The value is authored, not derived from the height.
- `CGS.UI.Badge` frames its icon in the 16 pt slot Figma authors, rather than sizing the glyph to the badge. Figma reuses one container across every size — a 16 pt box holding a 12 pt glyph — so `.small` and `.medium` were rendering their glyphs a third too large while their pill widths happened to land correctly. `.extraSmall` was wrong the other way: it reserved no slot and its `iconAndLabel` leading padding was 4 pt against Figma's 6 pt, so the pill came out 6 pt narrow. XS icon+label now measures 60 pt as published; SM and MD widths are unchanged.
- `PrimitiveColors.neutral50` light literal `#F5F5F5` → `#F5F5F7` to match the Figma export exactly.

### Removed

- Legacy Spacing case names (`xxs`, `xxl`, `xxxl`) — removed with no deprecation aliases. Callers get a compile error at every reference; rename per the value shifts in the `Spacing` entry under **Changed** or move to a semantically closer slot.
- `Icon.Action` and `Icon.Info` namespaces — removed with no deprecation aliases, see the icon taxonomy entry under **Changed**.

### Fixed

- Downloads recover from an expired reading ticket (401/403) instead of corrupting the item: engines no longer write a non-2xx response body to disk, the metadata fan-out refreshes the ticket and retries once, and the scheduler re-resolves fresh signed URLs with one bounded retry. Unrecoverable cases fail typed `CGS.Error.Downloads.unauthorized` instead of a generic error.
