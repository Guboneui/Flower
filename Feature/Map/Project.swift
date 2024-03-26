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
import UserKitPlugin

let projectName: String = "Map"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .Data.MapData.Main,
    .Domain.MapDomain.Main,
    .ThirdParty.Main,
    .DesignSystem.Main,
    .UserKit.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: true
)
