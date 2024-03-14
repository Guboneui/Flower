//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2024/03/15.
//

import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "UserKit"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)

