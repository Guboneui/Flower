//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/10/16.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DataPlugin
import DesignSystemPlugin
import DomainPlugin
import FeaturePlugin
import ThirdPartyDependencyPlugin
import UserKitPlugin

let projectName: String = "Login"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .ThirdParty.Main,
    .DesignSystem.Main,
    .Domain.LoginDomain.Main,
    .Data.LoginData.Main,
    .Feature.Main.Main,
    .UserKit.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: true
)
