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

let projectName: String = "LoginData"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: "LoginData",
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .Domain.LoginDomain.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)

