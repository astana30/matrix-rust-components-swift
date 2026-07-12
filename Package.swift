// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let version = "26.03.10"

let package = Package(
    name: "MatrixRustSDK",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "MatrixRustSDK", type: .dynamic, targets: ["MatrixRustSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "MatrixSDKFFI",
            url: "https://github.com/astana30/matrix-rust-sdk/releases/download/salemx-direct-call-key-envelope-f7c2cfe5c-packagingfix1/MatrixSDKFFI-f7c2cfe5c-packagingfix1.xcframework.zip",
            checksum: "f9ace1c50d7facf73c80feae349e8317de4d229ee21b53e91e2083e25124669c"
        ),
        .target(name: "MatrixRustSDK", dependencies: [.target(name: "MatrixSDKFFI")])
    ]
)
