// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let version = "26.03.10"

let package = Package(
    name: "MatrixRustSDK",
    platforms: [
        .iOS(.v16),
        .macOS(.v12)
    ],
    products: [
        .library(name: "MatrixRustSDK", type: .dynamic, targets: ["MatrixRustSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "MatrixSDKFFI",
            url: "https://github.com/astana30/matrix-rust-sdk/releases/download/salemx-cold-answer-current-state-f14c9056c/MatrixSDKFFI-f14c9056c.xcframework.zip",
            checksum: "c9001d145ede5d6eec14e4b0124c991fb4dc566c0a109c73ccea3263edef010e"
        ),
        .target(name: "MatrixRustSDK", dependencies: [.target(name: "MatrixSDKFFI")])
    ]
)
