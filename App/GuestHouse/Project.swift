import Foundation

import ProjectDescription

let name: String = "GuestHouse"
let bundleID: String = "com.boni.guestHouse.user.app"
let iOSTargetVersion: String = "16.0"
let buildVersion: String = "1.0.0"
let buildNumber: String = {
  let now = Date()
  let dataFormatter = DateFormatter()
  dataFormatter.dateFormat = "YYMMddHHmm"
  return "\(dataFormatter.string(from: now))009"
}()

let infoPlist: [String: Plist.Value] = [
  "CFBundleDevelopmentRegion": "ko_KR",
  "CFBundleShortVersionString": "1.0.0",
  "CFBundleVersion": "1",
  "UIMainStoryboardFile": "",
  "UILaunchStoryboardName": "LaunchScreen",
  "CFBundleIconName": "AppIcon",
  "NSAppTransportSecurity": [
    "NSAllowsArbitraryLoads": "YES"
  ],
  "NMFClientId": "wyq2xwziaq"
]

let baseSettings: [String: SettingValue] = [
  "CURRENT_PROJECT_VERSION": "\(buildNumber)", // 빌드
  "MARKETING_VERSION": "\(buildVersion)", // 버전
  "DEVELOPMENT_TEAM": "VKGAQDGK5R",
  "INFOPLIST_KEY_CFBundleDisplayName": "App",
  "ENABLE_BITCODE": "NO",
  "CODE_SIGN_STYLE": "Automatic"
]

let settings: Settings = .settings(
  base: baseSettings,
  configurations: [
    .debug(name: "Debug"),
    .release(name: "Release")
  ]
)

let appTarget: Target = .target(
  name: name,
  destinations: .iOS,
  product: .app,
  bundleId: bundleID,
  infoPlist: .extendingDefault(
    with: infoPlist
  ),
  sources: ["GuestHouse/Sources/**"],
  resources: ["GuestHouse/Resources/**"],
  dependencies: [
    // MARK: - Domain
    .project(target: "AppDomain", path: .relativeToRoot("Domain/AppDomain")),
    // MARK: - Data
    .project(target: "AppData", path: .relativeToRoot("Data/AppData")),
    // MARK: - Feature
    .project(target: "Login", path: .relativeToRoot("Feature/Login")),
    .project(target: "Main", path: .relativeToRoot("Feature/Main")),
    // MARK: - ThirdPartyKit
    .project(target: "ThirdPartyKit", path: .relativeToRoot("ThirdParty/ThirdPartyKit")),
  ],
  settings: settings
)

let project = Project(
  name: name,
  options: .options(
    developmentRegion: "ko",
    textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2)
  ),
  packages: [],
  settings: settings,
  targets: [appTarget]
)
