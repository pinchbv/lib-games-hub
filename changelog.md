# Changelog

## 0.3.0
- **Breaking change**: `GamesHubCallbacks` has been removed. The `callbacks` parameter on `GamesHubBuilder` is replaced by `onEvent: (GamesHubEvent) -> Unit`.
- **Breaking change**: Introduce `GamesHubEvent` sealed class. Each former callback corresponds to an `On*` subtype: `OnReady`, `OnInitialized`, `OnGameStarted`, `OnGamePaused`, `OnGameCompleted`, `OnShare`, `OnOpenUrl`, `OnGeneric`, `OnHeightCalculated`, `OnModalShown`, `OnStartScreenOpened`, `OnGameDataReceived`.
- [iOS] Fix retain cycle. The previous `GamesHubCallbacks` class was held strongly through the callback chain, causing a retain cycle between the host `UIViewController` and `GamesHubController`. The closure-based `onEvent` API allows using `[weak self]` to break the cycle.

## 0.2.1
- Handle ad link navigation on Android and iOS. Links that open in a new window (e.g. `window.open` / `target="_blank"`, as ad clicks do) are now forwarded through the `onOpenUrl` callback.
- Add `GamesHubMode` enum with values `Generic` and `NRC`, and a new optional `gamesHubMode` parameter on `GamesHubBuilder`.
- [iOS] Disable pinch-to-zoom in the iOS WebView.

## 0.2.0
- [iOS] Remove `frame` parameter from GamesHubBuilder. Use Auto Layout to constrain the size and position of the resulting view instead.
- Add `OpenUrl.Puzzle`. When available, this contains information about the puzzle that is about to be opened.
- Dependency update: Kotlin 2.3.21
- Dependency update: Kotlinx.serialization 1.11.0
- Dependency update: SKIE 0.10.12

## 0.1.10
- Add new callback: `onGameData`, which is triggered when a game data message is received.
- Add feature flags for external game title in initialization.
- Dependency update: Kotlin 2.3.10
- Dependency update: SKIE 0.10.10

## 0.1.9
- Add new method: `evaluateJavascript`, allows to run a javascript command in the GamesHub's WebView.
- Fixes an iOS bug where the white background flashes in dark mode.
- Dependency update: Kotlin 2.3.0
- Dependency update: SKIE 0.10.9
- Dependency update: Kotlinx.serialization 1.10.0
- Dependency update: Androidx Webkit 1.15.0
- Update Android targetSdk to 36

## 0.1.8
- Add new callback: `onModalShown`, which is triggered when any modal is shown.
- Add new callback: `onStartScreenOpened`, which is triggered when the start screen is opened. The start screen is a screen where it shows information about the puzzle before playing.
- Add new method: `closeOverlays`, allows to close any modal that is currently opened on the page.
- Dependency update: Kotlin 2.2.21

## 0.1.7
- Add new callback: `onReady`, which is triggered when the ready message is received from games app, indicating the app is ready to receive messages.
- Renamed `AppInitialized` message to `PuzzleData` which are used in `onReady` and `onInitialized`
- Add more logs to `AndroidWebView` and `iOSWebView`
- Dependency update: Kotlin 2.2.10
- Dependency update: SKIE 0.10.6

## 0.1.6
- Retain the webView's navigationDelegate object in iOS webView implementation

## 0.1.5
- Add new callback: `onInitialized`, which is triggered when the initialized message is received from games app, indicating the app successfully loaded
- Update Organization and Brand to `nrc` in Android app

## 0.1.4
- This version is similar to 0.1.3. 0.1.3 had checksum errors due to an error on the workflow.

## 0.1.3
- Add new callback: `onHeightCalculated`, which is triggered after a game loads and provides the calculated height of the web content
- Add new method: `setScrollEnabled`, allowing the host application to enable or disable scrolling within the GamesHub WebView.
- Add `CachePolicy` enum with values `Default, NoCache, CacheElseNetwork`
- Add new optional `cachePolicy` parameter to the `WebSource.Url` data class.
- Dependency update: Kotlin 2.2.0
- Dependency update: Kotlinx.serialization 1.9.0
- Dependency update: SKIE 0.10.4
- Dependency update: Androidx Webkit 1.14.0

## 0.1.2
- Add support to add `SafeArea`
- Add support to override `userAgent`
- Add support for handling any/generic messages.

## 0.1.1
- Downgrade iOS deploymentTarget to 15.0
- Restrict WebView debugging to iOS 16.4 and higher

## 0.1.0
- **Breaking change**: iOS framework is now exported as `GamesHub` (instead of `gameshub`).
- **Breaking change**: `GamesHub` (the result of calling `GamesHubBuilder().build()`) has been renamed to `GamesHubController`.
- **Breaking change**: The `Config` has moved from `GamesHubBuilder` to `GamesHubController.initialise(options)`.
- **Breaking change**: Sending messages has been replaced with calling functions. See available functions in `GamesHubController`. 
- **Breaking change**: Synced API with web. Removed `SetLanguage`, `SetPlatform`, `SetTitle`, `SetUserId`, `SetUserSubscription`.
- **Breaking change**: Added new callback: `onGamePaused`.
- Dependency update: Android Gradle Plugin 8.9.1

## 0.0.4
- Add support in handling links inside a page.
- Fix a bug on iOS header incorrectly passing the header.
- Dependency update: Androidx Webkit 1.13.0
- Dependency update: Androidx Activity 1.10.1
- Dependency update: Android Gradle Plugin 8.9.0
- Dependency update: Gradle Maven Publish Plugin 0.31.0

## 0.0.3
- Dependency update: Kotlin 2.1.10
- Dependency update: Kotlinx.serialization 1.8.0
- Dependency update: SKIE 0.10.1

## 0.0.2
- Add support for loading Html.

## 0.0.1
- Initial release.
