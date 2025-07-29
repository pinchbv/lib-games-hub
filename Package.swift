// swift-tools-version:5.3
import PackageDescription

// BEGIN KMMBRIDGE VARIABLES BLOCK (do not edit)
let remoteKotlinUrl = "https://maven.pinch.nl/maven/nl/pinch/gameshub-spm/0.1.5/gameshub-spm-0.1.5.zip"
let remoteKotlinChecksum = "224d336a347df7d27e182c557a63e26c651c57edf8c16d07aa5a7a280edb3300"
let packageName = "GamesHub"
// END KMMBRIDGE BLOCK

let package = Package(
    name: packageName,
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: packageName,
            targets: [packageName]
        ),
    ],
    targets: [
        .binaryTarget(
            name: packageName,
            url: remoteKotlinUrl,
            checksum: remoteKotlinChecksum
        )
        ,
    ]
)