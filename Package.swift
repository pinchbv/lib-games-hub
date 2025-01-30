// swift-tools-version:5.3
import PackageDescription

// BEGIN KMMBRIDGE VARIABLES BLOCK (do not edit)
let remoteKotlinUrl = "https://maven.pinch.nl/maven/nl/pinch/gameshub-spm/0.0.2/gameshub-spm-0.0.2.zip"
let remoteKotlinChecksum = "81cc82270e9f83fe53f41a690e3b14e14d311f06ac5bfd0b74c6c43301c1e613"
let packageName = "gameshub"
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