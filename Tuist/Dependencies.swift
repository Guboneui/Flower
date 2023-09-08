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
      .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "3.0.0"))
    ],
    productTypes: [
      "SnapKit": .framework,
      "Then": .framework
    ]
)

let dependencies = Dependencies(
    swiftPackageManager: thirdPartySPM,
    platforms: [.iOS]
)

