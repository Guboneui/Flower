//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/12/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DesignSystemPlugin
import FeaturePlugin
import ThirdPartyDependencyPlugin

let projectName: String = "Main"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .Feature.Chatting.Main,
    .Feature.Map.Main,
    .Feature.Profile.Main,
    .ThirdParty.Main,
    .DesignSystem.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: true
)
