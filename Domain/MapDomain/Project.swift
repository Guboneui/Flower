//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/12/30.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DomainPlugin
import EntityPlugin

let projectName: String = "MapDomain"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: projectName,
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .Entity.MapEntity.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)

