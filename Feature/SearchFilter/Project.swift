//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/11/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DataPlugin
import DesignSystemPlugin
import DomainPlugin
import SecureStorageKitPlugin
import ThirdPartyDependencyPlugin

let projectName: String = "SearchFilter"
let iOSTargetVersion: String = "16.0"

let project = Project.makeFrameworkProject(
  name: projectName,
  iOSTargetVersion: iOSTargetVersion,
  dependencies: [
    .ThirdParty.Main,
    .DesignSystem.Main,
    .SecureStorageKit.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: true
)

