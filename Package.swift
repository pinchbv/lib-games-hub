// swift-tools-version:5.3
import PackageDescription

// BEGIN KMMBRIDGE VARIABLES BLOCK (do not edit)
let remoteKotlinUrl = "https://maven.pinch.nl/maven/nl/pinch/gameshub-spm/0.1.6/gameshub-spm-0.1.6.zip"
let remoteKotlinChecksum = "8369297bfe0bd5912a75d45b41b68900c872e33510e5d1c37fec5ec64b6794cd"
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