// swift-tools-version:5.3
import PackageDescription

// BEGIN KMMBRIDGE VARIABLES BLOCK (do not edit)
let remoteKotlinUrl = "https://maven.pinch.nl/maven/nl/pinch/gameshub-spm/0.1.1/gameshub-spm-0.1.1.zip"
let remoteKotlinChecksum = "df57dc03dc2808fa34027b499ca3208405f7868d60447805f12ac0c16a4a1c67"
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