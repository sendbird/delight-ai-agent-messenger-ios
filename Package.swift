// swift-tools-version:5.10
import PackageDescription

// SendbirdAIAgentMessenger ships as a source target.
//
// 1.22.0 shipped it as a static xcframework. That static archive also absorbed
// SendbirdChatSDKWrapper.o, the glue target of a dependency package, so the symbols
// collide once the app builds that same target through SPM. -ObjC / -all_load /
// -force_load force archive members to be loaded, which turns the overlap into a
// link error (ld: 6 duplicate symbols).
//
// A source target builds no archive, so the problem does not arise.
// Xcode 27 support is already covered by making Core / Splash / SendbirdMarkdownUI /
// SendbirdNetworkImage binary, and Messenger does not need to be binary.
// Xcode 27 cannot set an app deployment target below iOS 15, so compiling the source
// target against the app deployment target stays consistent with Core's ios14.0
// swiftinterface.

let package = Package(
    name: "SendbirdAIAgentMessenger",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SendbirdAIAgentMessenger", targets: ["SendbirdAIAgentMessenger"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/sendbird/delight-ai-agent-core-ios",
            from: "1.23.0"
        )
    ],
    targets: [
        .target(
            name: "SendbirdAIAgentMessenger",
            dependencies: [
                .product(name: "SendbirdAIAgentCore", package: "delight-ai-agent-core-ios")
            ]
        )
    ]
)
