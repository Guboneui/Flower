//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/12/29.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DomainPlugin
import EntityPlugin

let projectName: String = "ChattingDomain"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: "ChattingDomain",
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .Entity.ChattingEntity.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)
