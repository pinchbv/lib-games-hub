> [!WARNING]  
> This SDK is still in development and the API may change/break over time. Feedback is appreciated!

# About GamesHub SDK

The primary goal of the GamesHub SDK is to simplify integrating with [Q42 Games & Puzzles](https://gameshub.42puzzles.com/) in native mobile apps, by taking away the boilerplate and allowing you to focus on relevant business logic. It provides a 'view' for apps to include in their view hierarchy, and a type-safe mechanism for sending and receiving messages.

This SDK is built using [Kotlin Multiplatform](https://kotlinlang.org/docs/multiplatform.html) and is compatible with Android (5 and up) and iOS (16 and up).

Get in touch with us more for information:
- GamesHub SDK for web: [Q42](https://gameshub.42puzzles.com/)
- GamesHub SDK for native apps: [PINCH](https://pinch.nl/en/contact-us/)

# Prerequisites

The GamesHub SDK requires a web page that embeds the GamesHub SDK. Read more about it [here](https://gameshub.42puzzles.com/hub-web) and reach out to Q42 to get set up!

# Setup

To add the GamesHub to your project, follow these steps:

* Add dependency
* Create instance via builder
* Add view
* Send and receive messages

Refer to the included sample apps and/or [documentation](docs/index.html) for more details.

## Android (& Kotlin Multiplatform)

### Add dependency

The GamesHub SDK is published to PINCH's Maven repository. Declare it e.g. in `settings.gradle(.kts)`.

```kotlin
repositories {
    google()
    mavenCentral()
    maven { url = uri("https://maven.pinch.nl/maven") }
}
```

Then add the dependency to your project (e.g. in `app/build.gradle(.kts)`).

```kotlin
dependencies {    
    implementation("nl.pinch:gameshub:x.y.z")
}
```

### Builder

Create a `Config`.

```kotlin
val config = Config(
    source = WebSource.Url(url = "https://www.nrc.nl/puzzels/appview"),
    client = "nrc",
    options = Options(
        language = Language.Dutch,
        player = Player.Anonymous,
    ),
)
```

(See `WebSource` for other options to load web content that embeds the GamesHub SDK for web)

Create an instance of the `GamesHub` using the `GamesHubBuilder`:

```kotlin
val gamesHub = GamesHubBuilder(
    context = this, // UI context; e.g. an Activity
    config = config,
    logger = LogCatLogger(Logger.Level.Debug),
    callbacks = object: GamesHubCallbacks {
        override fun onGameStarted(data: GameStarted) { /* */ }
        override fun onGameCompleted(data: GameCompleted) { /* */ }
        override fun onShare(data: Share) { /* */ }
        override fun onOpenUrl(data: OpenUrl) { /* */ }
    },
).build()
```

The `GamesHubCallbacks` is how you get notified about events happening in the GamesHub.

The resulting `GamesHub` will provide access to two key components further described below.


### GamesHubView
This is the visual part of the GamesHub. In order for anything to display, an app **must** add this to a view hierarchy. Call `view.get()` to get the underlying native view. On Android this is an [`android.view.View`](https://developer.android.com/reference/android/view/View). Add the view to an `Activity`, `Fragment` or `Composable` (using [`AndroidView`](https://developer.android.com/reference/kotlin/androidx/compose/ui/viewinterop/package-summary#AndroidView(kotlin.Function1,androidx.compose.ui.Modifier,kotlin.Function1))):

```kotlin
findViewById<ViewGroup>(R.id.gamesHubSlot)
    .addView(gamesHub.view.get())
```

### GamesHubMessageSender.
This is the mechanism to send messages to GamesHub. Refer to `OutboundMessage` for an overview of all available messages. The `Options` provided through the `Config` also translate to these messages and are automatically sent as part of initialising GamesHub. In general, messages only need to be sent for runtime changes that cannot be automatically picked up by the SDK.

Some examples include:
- When using an activity-based navigation stack, the view may not be destroyed and/or recreated when transiting from one destination to another. If the game state can change in any of the destinations, GamesHub will need to be explicitly informed to reflect the latest state when navigating back. The sample app showcases this, and informs GamesHub it received `Focus` again when an Activity gets resumed.
- When manually handling [configuration changes](https://developer.android.com/guide/topics/manifest/activity-element#config). In particular:
    - For `locale` changes, send `SetLanguage` with a language appropriate for the new locale.
    - For `uiMode` changes, send `SetTheme` with a light or dark theme.
- When the player state changes. If a player can log in as a registered user while the GamesHub is displaying, send relevant information using `SetPlayerId` and `SetPlayerSubscription`.

> [!TIP]  
> Config changes that cause the UI context (and therefore the GamesHub) to recreate will generally not have to be explicitly sent, provided these are reflected in the `Config`.

## iOS

### Add dependency (SPM)

The GamesHub SDK is available as package dependency using Swift Package Manager. To add it to your Xcode project, select **File** > **Add Package Dependency** and provide this repository for the Package URL:

```text
https://github.com/pinchbv/lib-games-hub
```

### Builder

Create a `Config`.

```swift
let config = Config(
    client: "nrc",
    source: WebSource.Url(url: "https://www.nrc.nl/puzzels/appview"),
    options: Options(language: Language.dutch, player: Player.companion.Anonymous)
)
```

(See `WebSource` for other options to load web content that embeds the GamesHub SDK for web)

Create an instance of the `GamesHub` using the `GamesHubBuilder`:

```swift
let gamesHub = GamesHubBuilder(
    frame: &self.view.bounds, // UIViewController view's bounds
    config: config,
    callbacks: {
        class GamesHubCallbacksImpl : GamesHubCallbacks {
            func onGameCompleted(data: GameCompleted) { /* */ }
            func onGameStarted(data: GameStarted) { /* */ }
            func onOpenUrl(data: OpenUrl) { /* */ }
            func onShare(data: Share) { /* */ }
        }
        return GamesHubCallbacksImpl()
    }(),
    logger: OSLogLogger(level: LoggerLevel.debug)
).build()
```

The `GamesHubCallbacks` is how you get notified about events happening in the GamesHub.

The resulting `GamesHub` will provide access to two key components further described below.

### GamesHubView
This is the visual part of the GamesHub. In order for anything to display, an app **must** add this to a view hierarchy. Call `view.get()` to get the underlying native view. On iOS this is a [`UIKit.UIView`](https://developer.apple.com/documentation/uikit/uiview). Add the view to a `UIViewController` or SwiftUI (using [`UIViewRepresentable`](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit)):

```swift
self.view = gamesHub.view.get()
```

### GamesHubMessageSender.
This is the mechanism to send messages to GamesHub. Refer to `OutboundMessage` for an overview of all available messages. The `Options` provided through the `Config` also translate to these messages and are automatically sent as part of initialising GamesHub. In general, messages only need to be sent for runtime changes that cannot be automatically picked up by the SDK.

Some examples include:
- When using an `UIViewController`-based navigation stack, the view is not destroyed and/or recreated when transiting from one destination to another. If the game state can change in any of the destinations, GamesHub will need to be explicitly informed to reflect the latest state when navigating back. The sample app showcases this, and informs GamesHub it received `Focus` again when an `UIViewController` will appear (again).
- When the app language changes (without the app restarting), send `SetLanguage` with a language appropriate for the new locale.
- When switching between light and dark mode, send `SetTheme` with the appropriate theme.
- When the player state changes. If a player can log in as a registered user while the GamesHub is displaying, send relevant information using `SetPlayerId` and `SetPlayerSubscription`.
