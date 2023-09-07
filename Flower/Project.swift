//
//  Project.swift
//  FlowerManifests
//
//  Created by 구본의 on 2023/09/08.
//
import Foundation

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName: String = "App"
private let bundleId: String = "com.flower.app"
private let iOSTargetVersiong: String = "16.0"
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
  "UILaunchStoryboardName": "LaunchScreen"
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
  deploymentTarget: .iOS(targetVersion: iOSTargetVersiong, devices: [.iphone]),
  infoPlist: .extendingDefault(with: infoPlist),
  sources: ["Sources/**"],
  resources: ["Resources/**"],
  dependencies: [],
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

