//
//  Project+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/09/09.
//

import ProjectDescription

// MARK: - FrameWork
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
    needTestTarget: Bool,
    needDemoAppTarget: Bool
  ) -> Project {
    
    let demoAppSetting: [String: SettingValue] = [
      "CURRENT_PROJECT_VERSION": "1", // 빌드
      "MARKETING_VERSION": "1.0.0", // 버전
      "DEVELOPMENT_TEAM": "VKGAQDGK5R",
      "INFOPLIST_KEY_CFBundleDisplayName": "App",
      "ENABLE_BITCODE": "NO",
      "CODE_SIGN_STYLE": "Automatic"
    ]
    
    let settingConfigurations: [ProjectDescription.Configuration] = [
      .debug(name: "Debug"),
      .release(name: "Release")
    ]
    
    var target = Target.makeFrameworkTargets(
      name: name,
      iOSTargetVersion: iOSTargetVersion,
      dependencies: dependencies,
      isDynamic: isDynamic,
      needTestTarget: needTestTarget
    )
    
    if needDemoAppTarget {
      target.append(
        Target(
          name: "\(name)DemoApp",
          platform: .iOS,
          product: .app,
          bundleId: "com.boni.\(name)Demoapp",
          deploymentTarget: .iOS(
            targetVersion: iOSTargetVersion,
            devices: [.iphone]
          ),
          infoPlist: InfoPlist.extendingDefault(
            with:
              [
                "CFBundleDevelopmentRegion": "ko_KR",
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1",
                "UILaunchStoryboardName": "LaunchScreen"
              ]
            
          ),
          sources: ["./DemoApp/Sources/**"],
          resources: ["./DemoApp/Resources/**"],
          dependencies: [.target(name: name)],
          settings: .settings(base: demoAppSetting, configurations: [])
        )
      )
    }
    
    return Project(
      name: name,
      options: .options(
        developmentRegion: "ko",
        textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2)
      ),
      settings: .settings(
        base: baseSetting,
        configurations: settingConfigurations,
        defaultSettings: .recommended
      ),
      targets: target
    )
  }
}

// MARK: - Library
public extension Project {
  static func makeLibraryProject(
    name: String,
    iOSTargetVersion: String,
    baseSetting: SettingsDictionary = [:],
    dependencies: [TargetDependency],
    isDynamic: Bool,
    needTestTarget: Bool,
    needDemoAppTarget: Bool
  ) -> Project {
    
    let demoAppSetting: [String: SettingValue] = [
      "CURRENT_PROJECT_VERSION": "1", // 빌드
      "MARKETING_VERSION": "1.0.0", // 버전
      "DEVELOPMENT_TEAM": "VKGAQDGK5R",
      "INFOPLIST_KEY_CFBundleDisplayName": "App",
      "ENABLE_BITCODE": "NO",
      "CODE_SIGN_STYLE": "Automatic"
    ]
    
    let settingConfigurations: [ProjectDescription.Configuration] = [
      .debug(name: "Debug"),
      .release(name: "Release")
    ]
    
    var target = Target.makeLibraryTargets(
      name: name,
      iOSTargetVersion: iOSTargetVersion,
      dependencies: dependencies,
      isDynamic: isDynamic,
      needTestTarget: needTestTarget
    )
    
    target.append(
      Target(
        name: "\(name)DemoApp",
        platform: .iOS,
        product: .app,
        bundleId: "com.boni.\(name)Demoapp",
        deploymentTarget: .iOS(
          targetVersion: iOSTargetVersion,
          devices: [.iphone]
        ),
        infoPlist: InfoPlist.extendingDefault(
          with:
            [
              "CFBundleDevelopmentRegion": "ko_KR",
              "CFBundleShortVersionString": "1.0",
              "CFBundleVersion": "1",
              "UILaunchStoryboardName": "LaunchScreen"
            ]
          
        ),
        sources: ["./DemoApp/Sources/**"],
        resources: ["./DemoApp/Resources/**"],
        dependencies: [.target(name: name)],
        settings: .settings(base: demoAppSetting, configurations: [])
      )
    )
    
    
    return Project(
      name: name,
      options: .options(
        developmentRegion: "ko",
        textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2)
      ),
      settings: .settings(
        base: baseSetting,
        configurations: settingConfigurations,
        defaultSettings: .recommended
      ),
      targets: target
    )
  }
}
