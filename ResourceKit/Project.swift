//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/09/09.
//

import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "ResourceKit"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)
