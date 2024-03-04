//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/12/29.
//

import ProjectDescription
import ProjectDescriptionHelpers

import NetworkHelperPlugin

let projectName: String = "ChattingNetwork"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: "ChattingNetwork",
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .NetworkHelper.Main,
//    .external(name: "RealmSwift")
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)
