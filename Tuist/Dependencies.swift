//
//  Dependencies.swift
//  Config
//
//  Created by 구본의 on 2023/09/09.
//

import ProjectDescription

let thirdPartySPM = SwiftPackageManagerDependencies(
  [
    .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.0")),
    .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0")),
    .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.0.0")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMajor(from: "4.0.0")),
    .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
    .remote(url: "https://github.com/Guboneui/NaverMap-SPM", requirement: .upToNextMajor(from: "3.17.0")),
    .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0")),
    .package(url: "https://github.com/airbnb/HorizonCalendar.git", from: "2.0.0")
  ],
  productTypes: [
    "SnapKit": .framework,
    "Then": .framework,
    "RxSwift": .framework,
    "RxGesture": .framework,
    "Moya": .framework,
    "NMapsMap": .framework,
    "ReactorKit": .framework,
    "HorizonCalendar": .framework
  ]
)

let dependencies = Dependencies(
  swiftPackageManager: thirdPartySPM,
  platforms: [.iOS]
)
