// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFirebaseTools",
		platforms: [.iOS(.v15), .macCatalyst(.v15), .macOS(.v10_15), .tvOS(.v15), .watchOS(.v7)],
    products: [
        .library(name: "SwiftFirebaseTools", targets: ["SwiftFirebaseTools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dankinsoid/swift-analytics.git", from: "1.10.0"),
        .package(url: "https://github.com/dankinsoid/swift-configs.git", from: "1.0.1"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftFirebaseTools",
            dependencies: [
                .product(name: "FirebaseAnalyticsCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
                .product(name: "FirebasePerformance", package: "firebase-ios-sdk"),
                .product(name: "SwiftAnalytics", package: "swift-analytics"),
                .product(name: "SwiftConfigs", package: "swift-configs"),
            ]
        ),
    ]
)
