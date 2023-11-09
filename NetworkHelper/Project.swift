//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/11/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "NetworkHelper"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: "NetworkHelper",
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .external(name: "RxMoya")
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)
