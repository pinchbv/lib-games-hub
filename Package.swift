// swift-tools-version:5.3
import PackageDescription

// BEGIN KMMBRIDGE VARIABLES BLOCK (do not edit)
let remoteKotlinUrl = "https://maven.pinch.nl/maven/nl/pinch/gameshub-spm/0.1.4/gameshub-spm-0.1.4.zip"
let remoteKotlinChecksum = "c47997e295e3f3acf67e5d011c3f651e6a05c48f0c446e4e0884e53b5256aa97"
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