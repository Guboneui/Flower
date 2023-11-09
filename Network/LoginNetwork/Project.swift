//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/11/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

import NetworkHelperPlugin

let projectName: String = "LoginNetwork"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: "LoginNetwork",
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .NetworkHelper.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)

