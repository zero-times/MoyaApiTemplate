// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoyaApiTemplate",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MoyaApiTemplate",
            targets: ["MoyaApiTemplate"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
        .package(url: "http://git.supericu.com:8099/hoa/HoUntils.git", Package.Dependency.Requirement._branchItem("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MoyaApiTemplate",
            dependencies: ["Moya", "SwiftyJSON", "HoUntils"]),
        .testTarget(
            name: "MoyaApiTemplateTests",
            dependencies: ["MoyaApiTemplate"]),
    ]
)
