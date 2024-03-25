// swift-tools-version:5.9

import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers


let packageSettings = PackageSettings(
  productTypes: [
    "SocketIO": .framework,
    "SnapKit": .framework,
    "RxSwift": .framework,
    "RxGesture": .framework,
    "Moya": .framework,
    "ReactorKit": .framework,
    "Nuke": .framework,
    "Then": .framework,
    "NMapsMap": .framework,
    "HorizonCalendar": .framework
  ]
)
#endif

let package = Package(
  name: "ThirdParty",
  dependencies: [
    .package(url: "https://github.com/socketio/socket.io-client-swift", .upToNextMajor(from: "16.1.0")),
    .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    .package(url: "https://github.com/RxSwiftCommunity/RxGesture", .upToNextMajor(from: "4.0.0")),
    .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
    .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0")),
    .package(url: "https://github.com/kean/Nuke", .upToNextMajor(from: "12.0.0")),
    .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "3.0.0")),
    .package(url: "https://github.com/Guboneui/NaverMap-SPM", .upToNextMajor(from: "3.17.0")),
    .package(url: "https://github.com/airbnb/HorizonCalendar.git", .upToNextMajor(from: "2.0.0"))
  ],
  targets: [
    .target(
      name: "ThirdParty",
      dependencies: ["RxMoya"]
    )
  ]
)
