> [!WARNING]  
> This SDK is still in development and the API may change/break over time. Feedback is appreciated!

# About GamesHub SDK

The primary goal of the GamesHub SDK is to simplify integrating with [Q42 Games & Puzzles](https://gameshub.42puzzles.com/) in native mobile apps, by taking away the boilerplate and allowing you to focus on relevant business logic. It provides a 'view' for apps to include in their view hierarchy, and a type-safe mechanism for sending and receiving messages.

This SDK is built using [Kotlin Multiplatform](https://kotlinlang.org/docs/multiplatform.html) and is compatible with Android (5 and up) and iOS (15 and up).

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

Create an instance of the `GamesHubController` using the `GamesHubBuilder`:

```kotlin
val gamesHubController = GamesHubBuilder(
    context = this, // UI context; e.g. an Activity
    source = WebSource.Url(url = startUrl),
    logger = LogCatLogger(Logger.Level.Debug),
    callbacks = object: GamesHubCallbacks {
        override fun onGameStarted(data: GameStarted) { /* */ }
        override fun onGamePaused(data: GamePaused) { /* */ }
        override fun onGameCompleted(data: GameCompleted) { /* */ }
        override fun onShare(data: Share) { /* */ }
        override fun onOpenUrl(data: OpenUrl) { /* */ }
    },
).build()
```

(See `WebSource` for other options to load web content that embeds the GamesHub SDK for web)

Initialize the `GamesHub` component using `Options`.

```kotlin
val options = Options(
    enableDebug = true,
    organisation = "nrc",
    brand = "nrc",
    theme = Theme.default,
    player = Player.Anonymous,
)

gamesHubController.initialize(options)
```

> [!IMPORTANT]  
> You need to call `gamesHubController.initialize()` in order to show Puzzles.

The `GamesHubCallbacks` is how you get notified about events happening in the GamesHub.

The resulting `GamesHubController` will provide access to a key component further described below.

### GamesHubView
This is the visual part of the GamesHub. In order for anything to display, an app **must** add this to a view hierarchy. Call `view.get()` to get the underlying native view. On Android this is an [`android.view.View`](https://developer.android.com/reference/android/view/View). Add the view to an `Activity`, `Fragment` or `Composable` (using [`AndroidView`](https://developer.android.com/reference/kotlin/androidx/compose/ui/viewinterop/package-summary#AndroidView(kotlin.Function1,androidx.compose.ui.Modifier,kotlin.Function1))):

```kotlin
findViewById<ViewGroup>(R.id.gamesHubSlot)
    .addView(gamesHubController.view.get())
```

### GamesHub methods
The **GamesHub SDK** provides essential configuration methods to customize the appearance and behavior of GamesHub.

Some examples include:
- When using an activity-based navigation stack, the view may not be destroyed and/or recreated when transiting from one destination to another. If the game state can change in any of the destinations, GamesHub will need to be explicitly informed to reflect the latest state when navigating back. The sample app showcases this, and informs GamesHub it received `focus()` again when an Activity gets resumed.
- When manually handling [configuration changes](https://developer.android.com/guide/topics/manifest/activity-element#config). For `uiMode` changes, call `setTheme()` with a light or dark theme.
- For additional logging, call `setDebug()`.

> [!TIP]  
> Config changes that cause the UI context (and therefore the GamesHub) to recreate will generally not have to be explicitly sent, provided these are reflected when calling `initialize()`.

## iOS

### Add dependency (SPM)

The GamesHub SDK is available as package dependency using Swift Package Manager. To add it to your Xcode project, select **File** > **Add Package Dependency** and provide this repository for the Package URL:

```text
https://github.com/pinchbv/lib-games-hub
```

### Builder

Create an instance of the `GamesHubController` using the `GamesHubBuilder`:

```swift
let gamesHubController = GamesHubBuilder(
    frame: &self.view.bounds, // UIViewController view's bounds
    config: config,
    callbacks: {
        class GamesHubCallbacksImpl : GamesHubCallbacks {
            func onGameCompleted(data: GameCompleted) { /* */ }
            func onGameStarted(data: GameStarted) { /* */ }
            func onGamePaused(data: GamePaused) { /* */ }
            func onOpenUrl(data: OpenUrl) { /* */ }
            func onShare(data: Share) { /* */ }
        }
        return GamesHubCallbacksImpl()
    }(),
    logger: OSLogLogger(level: LoggerLevel.debug)
).build()
```

(See `WebSource` for other options to load web content that embeds the GamesHub SDK for web)

Initialize the `GamesHub` component using `Options`.

```swift
let options = Options(
    enableDebug: true,
    organisation: "nrc",
    brand: "nrc",
    theme: Theme.default,
    player: Player.companion.Anonymous
)

gamesHubController.initialize(options: options)
```

> [!IMPORTANT]  
> You need to call `gamesHub.initialize()` in order to show Puzzles.

The `GamesHubCallbacks` is how you get notified about events happening in the GamesHub.

The resulting `GamesHub` will provide access to a key component further described below.

### GamesHubView
This is the visual part of the GamesHub. In order for anything to display, an app **must** add this to a view hierarchy. Call `view.get()` to get the underlying native view. On iOS this is a [`UIKit.UIView`](https://developer.apple.com/documentation/uikit/uiview). Add the view to a `UIViewController` or SwiftUI (using [`UIViewRepresentable`](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit)):

```swift
self.view = gamesHubController.view.get()
```

### GamesHub methods
The **GamesHub SDK** provides essential configuration methods to customize the appearance and behavior of GamesHub.

Some examples include:
- When using an `UIViewController`-based navigation stack, the view is not destroyed and/or recreated when transiting from one destination to another. If the game state can change in any of the destinations, GamesHub will need to be explicitly informed to reflect the latest state when navigating back. The sample app showcases this, and informs GamesHub it received `focus()` again when an `UIViewController` will appear (again).
- When switching between light and dark mode, call `setTheme()` with the appropriate theme.
- For additional logging, call `setDebug()`.