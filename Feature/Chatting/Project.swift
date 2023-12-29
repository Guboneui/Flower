//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/12/28.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DataPlugin
import DesignSystemPlugin
import DomainPlugin
import ThirdPartyDependencyPlugin

let projectName: String = "Chatting"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .Data.ChattingData.Main,
    .Domain.ChattingDomain.Main,
    .ThirdParty.Main,
    .DesignSystem.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: true
)
