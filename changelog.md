# Changelog

## 0.1.1
- Downgrade iOS deploymentTarget to 15.0

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
- 