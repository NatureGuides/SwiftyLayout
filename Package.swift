// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SwiftyLayout",
    platforms: [.iOS(.v9),
                .tvOS(.v9)],
    products: [
        .library(name: "SwiftyLayout", targets: ["SwiftyLayout"])
    ],
    targets: [
        .target(name: "SwiftyLayout", path: "SwiftyLayout"),
    ],
    swiftLanguageVersions: [.v5]
)
