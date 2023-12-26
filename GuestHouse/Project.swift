//
//  Project.swift
//  GuestHouseManifests
//
//  Created by 구본의 on 2023/09/08.
//
import Foundation

import ProjectDescription
import ProjectDescriptionHelpers

import DataPlugin
import DomainPlugin
import FeaturePlugin
import ResourceKitPlugin
import ThirdPartyDependencyPlugin

private let projectName: String = "App"
private let bundleId: String = "com.guesthouse.user.app"
private let iOSTargetVersion: String = "16.0"
private let buildVersion: String = "1.0.0"
private let buildNumber: String = {
  let now = Date()
  let dataFormatter = DateFormatter()
  dataFormatter.dateFormat = "YYMMddHHmm"
  return "\(dataFormatter.string(from: now))009"
}()

private let infoPlist: [String: InfoPlist.Value] = [
  "CFBundleShortVersionString": "1.0.0",
  "CFBundleVersion": "1",
  "UIMainStoryboardFile": "",
  "UILaunchStoryboardName": "LaunchScreen",
  "CFBundleIconName": "AppIcon",
  "NSAppTransportSecurity": [
    "NSAllowsArbitraryLoads": "YES"
  ]
]

private let baseSettings: [String: SettingValue] = [
  "CURRENT_PROJECT_VERSION": "\(buildNumber)", // 빌드
  "MARKETING_VERSION": "\(buildVersion)", // 버전
  "DEVELOPMENT_TEAM": "VKGAQDGK5R",
  "INFOPLIST_KEY_CFBundleDisplayName": "App",
  "ENABLE_BITCODE": "NO",
  "CODE_SIGN_STYLE": "Automatic"
]

private let settings: Settings = .settings(
  base: baseSettings,
  configurations: [
    .debug(name: "Debug"),
    .release(name: "Release")
  ]
)

private let appTarget: Target = Target(
  name: projectName,
  platform: .iOS,
  product: .app,
  bundleId: bundleId,
  deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
  infoPlist: .extendingDefault(with: infoPlist),
  sources: ["Sources/**"],
  resources: ["Resources/**"],
  scripts: [.SwiftLintScript],
  dependencies: [
    .ThirdParty.Main,
    
    .Feature.Login.Main,
    .Feature.SearchFilter.Main,
    .Feature.Main.Main,
    
    .Domain.Main,
    .Data.Main
  ],
  settings: settings
)

let project = Project(
  name: projectName,
  options: .options(
    developmentRegion: "ko",
    textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2)
  ),
  packages: [],
  settings: settings,
  targets: [appTarget]
)
