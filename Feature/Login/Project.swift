//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/10/16.
//

import ProjectDescription
import ProjectDescriptionHelpers

import ResourceKitPlugin
import ThirdPartyDependencyPlugin

let projectName: String = "Login"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .ThirdParty.Main,
    .ResourceKit.Main
  ],
  isDynamic: false,
  needTestTarget: false
)
