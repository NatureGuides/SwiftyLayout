// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "SwiftyLayout",
    platforms: [.iOS(.v12),
                .tvOS(.v12),
                .visionOS(.v1),
                .macCatalyst(.v13),
    ],
    products: [
        .library(name: "SwiftyLayout", targets: ["SwiftyLayout"])
    ],
    targets: [
        .target(name: "SwiftyLayout", path: "SwiftyLayout"),
    ],
    swiftLanguageModes: [.v6]
)
