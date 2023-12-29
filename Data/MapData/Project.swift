//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/12/30.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DataPlugin
import DomainPlugin
import NetworkPlugin

let projectName: String = "MapData"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: projectName,
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .Domain.MapDomain.Main,
    .Network.MapNetwork.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)

