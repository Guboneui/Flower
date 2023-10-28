//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/09/09.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ThirdPartyDependencyPlugin

let projectName: String = "ThirdPartyDependency"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: TargetDependency.ThirdParty.dependency,
  isDynamic: true,
  needTestTarget: false,
  needDemoAppTarget: false
)
