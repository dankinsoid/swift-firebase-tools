// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFirebaseTools",
    products: [
        .library(name: "SwiftFirebaseTools", targets: ["SwiftFirebaseTools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dankinsoid/swift-analytics.git", from: "1.10.0"),
        .package(url: "https://github.com/dankinsoid/swift-configs.git", from: "0.11.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftFirebaseTools",
            dependencies: [
                .product(name: "FirebaseAnalyticsSwift", package: "firebase-ios-sdk"),
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
                .product(name: "FirebasePerformance", package: "firebase-ios-sdk"),
                .product(name: "SwiftAnalytics", package: "swift-analytics"),
                .product(name: "SwiftConfigs", package: "swift-configs"),
            ]
        ),
    ]
)
