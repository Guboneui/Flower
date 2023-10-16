//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/10/16.
//

import ProjectDescription
import ProjectDescriptionHelpers
import FeaturePlugin

let projectName: String = "Feature"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .Feature.Login.Main
  ],
  isDynamic: false,
  needTestTarget: false
)


