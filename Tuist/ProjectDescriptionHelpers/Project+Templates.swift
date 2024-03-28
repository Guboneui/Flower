//
//  Project+Templates.swift
//  MyTemplateManifests
//
//  Created by 구본의 on 2024/03/21.
//

import ProjectDescription

extension Project {
  public static func featureFramework(
    name: String,
    packages: [Package] = [],
    dependencies: [TargetDependency] = [],
    ifNeedTestTarget: Bool = false
  ) -> Project {
    var targets: [Target] = [
      .target(
        name: name,
        destinations: .iOS,
        product: .framework,
        bundleId: "com.boni.guesthouse.\(name)",
        deploymentTargets: .iOS("16.0"),
        infoPlist: .default,
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        dependencies: dependencies
      )
    ]
    
    if ifNeedTestTarget {
      targets.append(
        .target(
          name: "\(name)Tests",
          destinations: .iOS,
          product: .unitTests,
          bundleId: "com.boni.guesthouse.\(name)Tests",
          deploymentTargets: .iOS("16.0"),
          infoPlist: .default,
          sources: ["Sources/**"],
          resources: ["Resources/**",],
          dependencies: [.target(name: name)]
        )
      )
    }
    
    return Project(
      name: name,
      packages: packages,
      targets: targets
    )
  }
  
  public static func featureLibrary(
    name: String,
    packages: [Package] = [],
    dependencies: [TargetDependency] = [],
    ifNeedDemoApp: Bool = false,
    demoAppPlist: [String: Plist.Value] = [:]
  ) -> Project {
    var targets: [Target] = [
      .target(
        name: name,
        destinations: .iOS,
        product: .staticLibrary,
        bundleId: "com.boni.guesthouse.\(name)",
        deploymentTargets: .iOS("16.0"),
        infoPlist: .default,
        sources: ["Sources/**"],
        dependencies: dependencies
      )
    ]
    
    if ifNeedDemoApp {
      let demoAppSetting: [String: SettingValue] = [
        "CURRENT_PROJECT_VERSION": "1", // 빌드
        "MARKETING_VERSION": "1.0.0", // 버전
        "DEVELOPMENT_TEAM": "VKGAQDGK5R",
        "INFOPLIST_KEY_CFBundleDisplayName": "App",
        "ENABLE_BITCODE": "NO",
        "CODE_SIGN_STYLE": "Automatic"
      ]
      
      let domoAppDefaultInfoPlist: [String: Plist.Value] = [
        "CFBundleDevelopmentRegion": "ko_KR",
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "UILaunchStoryboardName": "LaunchScreen.storyboard",
        "NSAppTransportSecurity": [
          "NSAllowsArbitraryLoads": "YES"
        ],
        "NMFClientId": "wyq2xwziaq"
      ]
      
      targets.append(
        .target(
          name: "\(name)DemoApp",
          destinations: .iOS,
          product: .app,
          bundleId: "com.boni.guesthouse.\(name)DemoApp",
          deploymentTargets: .iOS("16.0"),
          infoPlist: .extendingDefault(
            with: domoAppDefaultInfoPlist.merging(demoAppPlist) { (_, new) in new }
          ),
          sources: ["./DemoApp/Sources/**"],
          resources: ["./DemoApp/Resources/**"],
          dependencies: [.target(name: name)],
          settings: .settings(base: demoAppSetting, configurations: [])

        )
      )
    }
    
    let settingConfigurations: [ProjectDescription.Configuration] = [
      .debug(name: "Debug"),
      .release(name: "Release")
    ]
    
    return Project(
      name: name,
      options: .options(
        developmentRegion: "ko",
        textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2)
      ),
      packages: packages,
      settings: .settings(
        base: [:],
        configurations: settingConfigurations,
        defaultSettings: .recommended
      ),
      targets: targets
    )
  }
}
