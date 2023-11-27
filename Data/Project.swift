//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/11/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DataPlugin
import DomainPlugin
import NetworkPlugin

let projectName: String = "Data"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: "Data",
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .Domain.Main,
    .Data.LoginData.Main,
    .Network.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)
