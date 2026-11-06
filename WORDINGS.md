<!-- Generated at each release from the SDK and reader catalogues. Do not edit. -->
# Wording keys

Every text the SDK draws, by key, with the value English users see. Override any of them
through `CGS.Localization.setOverrides(_:)`, as the [README](README.md#wordings-and-language) describes.

> **Alpha — `0.x`.** Keys may still be renamed while the SDK is `0.x`; a rename is listed in
> [`CHANGELOG.md`](CHANGELOG.md) like any other breaking change. Placeholders (`%@`, `%lld`,
> `%d`) must be kept in an overridden value: an override whose placeholders do not match is
> ignored, reported through `CGS.Logger`, and the SDK's own wording is drawn.

## Error states

| Key | English value |
|---|---|
| `cgs.ui.errorState.generic.subtitle` | Please try again later |
| `cgs.ui.errorState.generic.title` | A technical issue occurred |
| `cgs.ui.errorState.network.subtitle` | Please check your connection and try again |
| `cgs.ui.errorState.network.title` | This content couldn't be loaded |
| `cgs.ui.errorState.retry.button` | Retry |

## Sections

| Key | English value |
|---|---|
| `cgs.ui.section.errorState.title` | This content couldn't be loaded |
| `cgs.ui.section.retry.button` | Retry |
| `cgs.ui.sectionPage.errorState.title` | This content couldn't be loaded |
| `cgs.ui.sectionPage.retry.button` | Retry |
| `cgs.ui.sectionPage.unavailableState.subtitle` | Please try again later |
| `cgs.ui.sectionPage.unavailableState.title` | A technical issue occurred |

## Issue cells

| Key | English value |
|---|---|
| `cgs.ui.issueCell.deleteDownload.option` | Delete |
| `cgs.ui.issueCell.download.failed.state` | Failed |
| `cgs.ui.issueCell.download.option` | Download |
| `cgs.ui.issueCell.download.waiting.state` | Waiting |
| `cgs.ui.issueCell.downloaded.description` | Downloaded |
| `cgs.ui.issueCell.freePages.tag` | %lld free page / %lld free pages (plural) |
| `cgs.ui.issueCell.locked.description` | Locked |
| `cgs.ui.issueCell.new.tag` | New |
| `cgs.ui.issueCell.read.tag` | Read |
| `cgs.ui.issueCell.sponsored.tag` | Sponsored |
| `cgs.ui.issueItem.advertising.tag` | Advertising |
| `cgs.ui.issueItem.new.tag` | New |

## Article cards

| Key | English value |
|---|---|
| `cgs.ui.articleCard.readingTime.label` | %lld min to read |
| `cgs.ui.articleCard.sponsored.tag` | Sponsored |
| `cgs.ui.articleTimelineCell.locked.description` | Locked |

## Publication page

| Key | English value |
|---|---|
| `cgs.ui.publicationScreen.allArticles.button` | All articles |
| `cgs.ui.publicationScreen.archivesSection.title` | Archives |
| `cgs.ui.publicationScreen.articlesSection.title` | Summary |
| `cgs.ui.publicationScreen.featuredIssue.read.button` | Read |
| `cgs.ui.publicationScreen.supplementsSection.title` | Supplements |

## Library page

| Key | English value |
|---|---|
| `cgs.ui.libraryScreen.emptyState.message` | Issues you download will appear here for offline reading. |
| `cgs.ui.libraryScreen.emptyState.title` | No downloads yet |

## Documents space

| Key | English value |
|---|---|
| `cgs.ui.mediaScreen.emptyState.message` | Published documents will appear here. |
| `cgs.ui.mediaScreen.emptyState.title` | No documents |
| `cgs.ui.mediaScreen.typeSelector.all.option` | All types |
| `cgs.ui.mediaScreen.typeSelector.title` | Document type |

## Videos

| Key | English value |
|---|---|
| `cgs.ui.videosPlayerScreen.errorState.subtitle` | Please try again later |
| `cgs.ui.videosPlayerScreen.errorState.title` | A technical issue occurred |
| `cgs.ui.videosPlayerScreen.follow.button` | Follow |
| `cgs.ui.videosPlayerScreen.following.button` | Following |
| `cgs.ui.videosPlayerScreen.retry.button` | Retry |
| `cgs.ui.videosPlayerScreen.sponsored.tag` | Sponsored |

## Checkbox

| Key | English value |
|---|---|
| `cgs.ui.checkbox.mixed.description` | Partially selected |

## Text fields

| Key | English value |
|---|---|
| `cgs.ui.passwordField.hide.action` | Hide password |
| `cgs.ui.passwordField.show.action` | Show password |
| `cgs.ui.textField.error.description` | Error |
| `cgs.ui.textField.info.description` | Information |
| `cgs.ui.textField.mandatory.description` | Required |
| `cgs.ui.textField.valid.description` | Valid |
| `cgs.ui.textField.warning.description` | Warning |

## Reader

The reader ships its own catalogue; its keys are overridable through the same file.

| Key | English value |
|---|---|
| `onereader.articleNative.infos.readingTime.format` | %d min |
| `onereader.articleNative.loadingFailedAlert.network.message` | You no longer seem to be connected to the internet. Check your connection and try again. |
| `onereader.articleNative.loadingFailedAlert.other.message` | We are having some technical issues. Try again in a few moments. |
| `onereader.articleNative.loadingFailedAlert.secondaryAction.text` | OK |
| `onereader.articleNative.loadingFailedAlert.title` | Oops! |
| `onereader.articleNative.nextArticle.advertisement.title` | Next |
| `onereader.articleNative.nextArticle.next` | Next |
| `onereader.articleNative.source.ctaButton.title` | Open this issue |
| `onereader.articleNative.source.text.format` | This article comes from no. %@ p.%@ - Published on %@ |
| `onereader.articleReader.audio.listen.title` | Listen |
| `onereader.articleReader.bookmark.activate.title` | Save |
| `onereader.articleReader.bookmark.deactivate.title` | Saved |
| `onereader.articleReader.fisheye.pageLabel.format` | p.%d |
| `onereader.articleReader.settings.title` | Customize |
| `onereader.articleReader.share.title` | Share |
| `onereader.articleReader.textToSpeech.activate.title` | Activate |
| `onereader.articleReader.textToSpeech.deactivate.title` | Deactivate |
| `onereader.articlereader.searchResultsIndicator.text` | Results |
| `onereader.bottomSheet.capsule.articles.many.format` | %d Articles |
| `onereader.bottomSheet.capsule.articles.one.text` | 1 Article |
| `onereader.navigationbar.searchbar.cancel` | Cancel |
| `onereader.pagesLoader.loadingFailedAlert.networkError.message` | The title could not be loaded. Please try again in a few moments. |
| `onereader.pagesLoader.loadingFailedAlert.networkError.title` | No internet connection |
| `onereader.pagesLoader.loadingFailedAlert.otherError.message` | The title could not be loaded. Please try again in a few moments. |
| `onereader.pagesLoader.loadingFailedAlert.otherError.title` | An error has occured |
| `onereader.pagesLoader.loadingFailedAlert.primaryAction.text` | Try again |
| `onereader.pagesLoader.loadingFailedAlert.secondaryAction.text` | Close |
| `onereader.reader.noArticles.text` | This issue is only available  in PDF |
| `onereader.readerPageAd.countdown.format` | This content will disappear in %d seconds |
| `onereader.readerTutorial.skipButton.skip.title` | Skip |
| `onereader.readerTutorial.skipButton.start.title` | Start to read |
| `onereader.readerTutorialItem.articleCapsule.text` | 2 articles |
| `onereader.readerTutorialItem.articleReader.description` | Customize your reading experience: dark mode, text size, brightness, all accessible in one click. |
| `onereader.readerTutorialItem.articleReader.title1` | An enhanced |
| `onereader.readerTutorialItem.articleReader.title2` | reading experience |
| `onereader.readerTutorialItem.articles.description` | Click on the bubble at the bottom of the screen to display the page articles. Find the table of contents by clicking on the icon at the top right. |
| `onereader.readerTutorialItem.articles.longPressEnabled.description` | Tap the ‘Article’ bubble at the bottom of the screen to see the different articles in an issue. A long tap on the page will open the desired article. |
| `onereader.readerTutorialItem.articles.title1` | Show articles |
| `onereader.readerTutorialItem.articles.title2` | easily |
| `onereader.readerTutorialItem.reader.description` | Scroll through the pages, use the thumbnails to move forward quickly, zoom with a double-click |
| `onereader.readerTutorialItem.reader.title1` | Navigate easily |
| `onereader.readerTutorialItem.reader.title2` | in your issue |
| `onereader.readerTutorialItem.share.description` | In one click, save your articles for later or share them around you. |
| `onereader.readerTutorialItem.share.title1` | You enjoyed an article? |
| `onereader.readerTutorialItem.share.title2` | Save and share it! |
| `onereader.readerTutorialItem.summary.description` | Discover at a glance the content of your issue, scroll and filter to easily find the article you are looking for. |
| `onereader.readerTutorialItem.summary.title1` | Find all articles in the |
| `onereader.readerTutorialItem.summary.title2` | table of contents |
| `onereader.readerTutorialItem.welcome.description` | Discover the new features |
| `onereader.readerTutorialItem.welcome.title1` | Welcome to your |
| `onereader.readerTutorialItem.welcome.title2` | reader! |
| `onereader.search.emptyState.idle.title` | Search an article, a topic… |
| `onereader.search.emptyState.loadingFailed.action` | Try again |
| `onereader.search.emptyState.loadingFailed.description` | We are having some technical issues. Try again in a few moments. |
| `onereader.search.emptyState.loadingFailed.network.description` | Please try again in a few moments. |
| `onereader.search.emptyState.loadingFailed.network.title` | No internet connection |
| `onereader.search.emptyState.loadingFailed.title` | Oops! |
| `onereader.search.emptyState.noResults.description` | Please double check your search or try again. |
| `onereader.search.emptyState.noResults.title` | Sorry we couldn’t find any match for “%@“ |
| `onereader.search.emptyState.notEnoughChars.description` | Your search must include at least three characters. |
| `onereader.search.emptyState.notEnoughChars.title` | Sorry we couldn’t find any match for “%@“ |
| `onereader.search.header.text.plural` | results |
| `onereader.search.header.text.singular` | result |
| `onereader.summary.articleCell.readingTime.format` | %d min |
| `onereader.summary.filterItem.all.text` | All |
| `onereader.summary.header.title` | Summary |
| `onereader.summary.searchBar.placeholder` | Enter your search |
