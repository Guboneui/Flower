//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/12/28.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DesignSystemPlugin
import ThirdPartyDependencyPlugin

let projectName: String = "Map"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .ThirdParty.Main,
    .DesignSystem.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: true
)
