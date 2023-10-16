//
//  Project+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/09/09.
//

import ProjectDescription

public extension Project {
  
  /// - Parameters:
  ///   - name: 타겟 이름
  ///   - iOSTargetVersion: iOS 최소 타겟 버전,
  ///   - baseSetting: TargetSetting,
  ///   - dependencies: TargetDependency
  ///   - isDynamic: Dynamic Framework 여부
  ///   - needTestTarget: 테스트 타겟 필요 여부
  static func makeFrameworkProject(
    name: String,
    iOSTargetVersion: String,
    baseSetting: SettingsDictionary = [:],
    dependencies: [TargetDependency],
    isDynamic: Bool,
    needTestTarget: Bool
  ) -> Project {
    
    let settingConfigurations: [ProjectDescription.Configuration] = [
      .debug(name: "Debug"),
      .release(name: "Release")
    ]
    
    let target = Target.makeFrameworkTargets(
      name: name,
      iOSTargetVersion: iOSTargetVersion,
      dependencies: dependencies,
      isDynamic: isDynamic,
      needTestTarget: needTestTarget
    )
    
    return Project(
      name: name,
      settings: .settings(
        base: baseSetting,
        configurations: settingConfigurations,
        defaultSettings: .recommended
      ),
      targets: target
    )
  }
  
  static func makeLibraryProject(
    name: String,
    iOSTargetVersion: String,
    baseSetting: SettingsDictionary = [:],
    dependencies: [TargetDependency],
    isDynamic: Bool,
    needTestTarget: Bool
  ) -> Project {
    
    let settingConfigurations: [ProjectDescription.Configuration] = [
      .debug(name: "Debug"),
      .release(name: "Release")
    ]
    
    let target = Target.makeLibraryTargets(
      name: name,
      iOSTargetVersion: iOSTargetVersion,
      dependencies: dependencies,
      isDynamic: isDynamic,
      needTestTarget: needTestTarget
    )
    
    return Project(
      name: name,
      settings: .settings(
        base: baseSetting,
        configurations: settingConfigurations,
        defaultSettings: .recommended
      ),
      targets: target
    )
  }
}
