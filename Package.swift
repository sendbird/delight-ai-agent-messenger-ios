// swift-tools-version:5.10
import PackageDescription

// SendbirdAIAgentMessenger 는 바이너리로 배포한다.
//
// 소스로 두면 Xcode 27 이 iOS 15.0 으로 올려서 빌드한다. 그러면 min iOS 14 를
// 선언한 앱이 iOS 15 오브젝트를 링크하게 된다. xcframework 안의
// swiftinterface 는 -target arm64-apple-ios14.0 으로 고정돼 있다.
//
// xcframework 는 ai-agent-ios 의 scripts/build_messenger_framework.sh 가
// Xcode 26 으로 만든다. 빌드 입력은 이 레포의 Sources/ 다. 고객이 1.21.0 까지
// 직접 컴파일하던 소스를 그대로 빌드하므로 public API 는 바뀌지 않는다.
// Sources/ 는 SwiftPM 타깃에 물리지 않지만 삭제하면 xcframework 를 만들 수 없다.

let package = Package(
    name: "SendbirdAIAgentMessenger",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SendbirdAIAgentMessenger", targets: ["SendbirdAIAgentMessengerTarget"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/sendbird/delight-ai-agent-core-ios",
            from: "1.21.0"
        )
    ],
    targets: [
        .binaryTarget(
            name: "SendbirdAIAgentMessenger",
            url: "https://github.com/sendbird/delight-ai-agent-messenger-ios/releases/download/1.21.0/SendbirdAIAgentMessenger.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"
        ),
        // binaryTarget 은 의존을 선언할 수 없다. 이 빈 타깃이 Core 를 묶는다.
        .target(
            name: "SendbirdAIAgentMessengerTarget",
            dependencies: [
                .target(name: "SendbirdAIAgentMessenger"),
                .product(name: "SendbirdAIAgentCore", package: "delight-ai-agent-core-ios")
            ],
            path: "Framework/Dependency"
        )
    ]
)
