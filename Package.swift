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
            url: "https://github.com/astana30/matrix-rust-sdk/releases/download/salemx-message-like-custom-content-8fe35ac28/MatrixSDKFFI-8fe35ac28.xcframework.zip",
            checksum: "5cca85c5ab7612eb8db5761375d476527693368d79f28dcbbd0ded2f7a26f5d9"
        ),
        .target(name: "MatrixRustSDK", dependencies: [.target(name: "MatrixSDKFFI")])
    ]
)
