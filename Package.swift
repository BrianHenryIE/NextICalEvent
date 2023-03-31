// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "NextICalEventParser",
        platforms: [
            .macOS(.v13)
        ],
        products: [
            .library(
                    name: "NextICalEventParser",
                    targets: ["NextICalEventParser"]
            ),
            .executable(name: "NextICalEvent", targets: ["NextICalEvent"])
        ],
        dependencies: [
            .package(
                    url: "https://github.com/chan614/iCalSwift",
                    branch: "master"
            ),
            .package(
                    url: "https://github.com/swift-server/swift-aws-lambda-runtime.git",
                    .upToNextMajor(from:"1.0.0-alpha.1")
            ),
            .package(
                    url: "https://github.com/swift-server/swift-aws-lambda-events.git",
                    .upToNextMajor(from:"0.1.0")
            ),
            .package(
                    url: "https://github.com/swift-server/async-http-client.git",
                    from: "1.9.0"
            )
        ],
        targets: [
            .executableTarget(
                    name: "NextICalEvent",
                    dependencies: [
                        .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
                        .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events"),
                        "NextICalEventParser",
                        .product(name: "AsyncHTTPClient", package: "async-http-client"),
                    ],
                    path: "Sources/NextICalEvent"
            ),
            .target(
                    name: "NextICalEventParser",
                    dependencies: [
                        .product(name: "ICalSwift", package: "ICalSwift"),
                    ],
                    path: "Sources/NextICalEventParser"
            ),
            .testTarget(
                    name: "NextICalEventParserTests",
                    dependencies: [
                        "NextICalEventParser",
                        .product(name: "AsyncHTTPClient", package: "async-http-client"),
                    ],
                    path: "Tests",
                    exclude: [],
                    sources: nil,
                    resources: [
                        .process("NextICalEventParser/Resources")
                    ]
            )
        ]
)
