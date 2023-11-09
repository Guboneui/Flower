//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/10/16.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DesignSystemPlugin
import EntityPlugin
import ThirdPartyDependencyPlugin

let projectName: String = "Login"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .ThirdParty.Main,
    .DesignSystem.Main,
    .Entity.LoginEntity.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: true
)
