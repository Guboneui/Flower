//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/12/29.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DataPlugin
import DomainPlugin
import NetworkPlugin

let projectName: String = "ChattingData"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: "ChattingData",
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .Domain.ChattingDomain.Main,
    .Network.ChattingNetwork.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)
