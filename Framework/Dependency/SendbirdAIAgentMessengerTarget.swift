// SendbirdAIAgentMessengerTarget 타깃의 유일한 소스 파일.
//
// binaryTarget 은 의존을 선언할 수 없다. 그래서 이 빈 타깃이
// SendbirdAIAgentMessenger xcframework 와 SendbirdAIAgentCore product 를
// 함께 묶는다 (Package.swift 참고).
//
// SwiftPM 은 소스 파일이 하나도 없는 타깃을 거부한다. 이 파일을 지우면
// 패키지 해석이 실패하고 SendbirdAIAgentMessenger product 가 깨진다.
