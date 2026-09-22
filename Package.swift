// swift-tools-version:5.10
import PackageDescription

// SendbirdAIAgentMessenger 는 소스로 배포한다.
//
// 1.22.0 에서는 static xcframework 로 배포했다. 그 static 아카이브가 의존 패키지의
// 글루 타깃 SendbirdChatSDKWrapper.o 까지 함께 흡수했고, 앱이 같은 타깃을 SPM 으로
// 빌드하면 심볼이 겹친다. -ObjC / -all_load / -force_load 는 아카이브 멤버를 강제로
// 끌어오므로 그 겹침이 링크 에러가 된다 (ld: 6 duplicate symbols).
//
// 소스 타깃은 아카이브를 만들지 않아 이 문제가 성립하지 않는다.
// Xcode 27 대응은 Core / Splash / SendbirdMarkdownUI / SendbirdNetworkImage 의
// 바이너리화로 이미 해결되어 있고, Messenger 는 바이너리일 필요가 없다.
// Xcode 27 은 앱 배포 타깃을 iOS 15 미만으로 만들지 못하므로, 소스 타깃이
// 앱 배포 타깃으로 컴파일되어도 Core 의 ios14.0 swiftinterface 와 어긋나지 않는다.

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
