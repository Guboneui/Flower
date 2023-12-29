//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2023/11/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

import NetworkHelperPlugin
import NetworkPlugin
import ThirdPartyDependencyPlugin

let projectName: String = "Network"
let iOSTargetVersion: String = "16.0"

let project = Project.makeLibraryProject(
  name: "Network",
  iOSTargetVersion: "16.0",
  baseSetting: .init(),
  dependencies: [
    .NetworkHelper.Main,
    .Network.LoginNetwork.Main,
    .Network.MapNetwork.Main
  ],
  isDynamic: false,
  needTestTarget: false,
  needDemoAppTarget: false
)
