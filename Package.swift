// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XrayService",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "XrayService",
            targets: ["XrayService"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/EbrahimTahernejad/Tun2SocksKit", .upToNextMajor(from: "3.6.8")),
        .package(url: "https://github.com/lestar348/XRayCoreIOSWrapper", .branch("update_core")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "XrayService",
            dependencies: [
                "Tun2SocksKit",
                "XRayCoreIOSWrapper",
            ]
        ),
    ]
)
