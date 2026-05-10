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
            url: "https://github.com/astana30/matrix-rust-sdk/releases/download/salemx-custom-message-like-timeline-filter-b10cf4652/MatrixSDKFFI-b10cf4652.xcframework.zip",
            checksum: "2bc96dcfc3fd8d5157a869660c6350612fa56c76ae5888bdcb0dac77941686e8"
        ),
        .target(name: "MatrixRustSDK", dependencies: [.target(name: "MatrixSDKFFI")])
    ]
)
