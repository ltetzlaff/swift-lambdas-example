// swift-tools-version:5.2
import PackageDescription

func withLambdaRuntime(name: String, withDependencies deps: [Target.Dependency] = []) -> Target {
    .target(
        name: name,
        dependencies: deps + [
            .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
        ]
    )
}

func withLambdaHTTPRuntime(name: String) -> Target {
    withLambdaRuntime(name: name, withDependencies: [
        .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime")
    ])
}

let package = Package(
    name: "Swift Lambdas",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "Hello", targets: ["Hello"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.23.0"),
    ],
    targets: [
        withLambdaHTTPRuntime(name: "HTTPLambda"),

        // Lambda Handlers
        .target(
            name: "Hello",
            dependencies: ["HTTPLambda"]
        ),
    ]
)
