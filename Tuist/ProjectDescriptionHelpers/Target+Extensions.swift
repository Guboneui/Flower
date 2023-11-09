//
//  Target+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/09/09.
//

import ProjectDescription

public extension Target {
  
  /// - Parameters:
  ///   - name: 타겟 이름
  ///   - iOSTargetVersion: iOS 최소 타겟 버전,
  ///   - dependencies: TargetDependency
  ///   - isDynamic: Dynamic Framework 여부
  ///   - needTestTarget: 테스트 타겟 필요 여부
  static func makeFrameworkTargets(
    name: String,
    iOSTargetVersion: String,
    dependencies: [TargetDependency],
    isDynamic: Bool,
    needTestTarget: Bool
  ) -> [Target] {
    var targets: [Target] = []
    
    let bundleID: String = "com.guesthouse.user"
    
    targets.append(Target(
      name: name,
      platform: .iOS,
      product: isDynamic ? .framework : .staticFramework,
      productName: name,
      bundleId: "\(bundleID).\(name)",
      deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: .iphone),
      infoPlist: .default,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: [.SwiftLintScript],
      dependencies: dependencies
    ))
    
    if needTestTarget {
      targets.append(
        Target(
          name: "\(name)Tests",
          platform: .iOS,
          product: .unitTests,
          productName: "\(name)Tests",
          bundleId: "\(bundleID).\(name)Tests",
          deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: .iphone),
          infoPlist: .default,
          sources: ["Tests/**"],
          scripts: [.SwiftLintScript],
          dependencies: [.target(name: name)]
        )
      )
    }
    
    return targets
  }
}

// MARK: - Library

public extension Target {
  static func makeLibraryTargets(
    name: String,
    iOSTargetVersion: String,
    dependencies: [TargetDependency],
    isDynamic: Bool,
    needTestTarget: Bool
  ) -> [Target] {
    
    var targets: [Target] = []
    
    let bundleID: String = "com.guesthouse.user"
    
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: isDynamic ? .dynamicLibrary : .staticLibrary,
      productName: name,
      bundleId: "\(bundleID).\(name)",
      deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: .iphone),
      infoPlist: .default,
      sources: ["Sources/**"],
      scripts: [.SwiftLintScript],
      dependencies: dependencies
    )
    
    targets.append(mainTarget)

    return targets
  }
}
