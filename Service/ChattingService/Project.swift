//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "ChattingService"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    .project(
      target: "NetworkHelper",
      path: "../NetworkHelper"
    )
  ]
)
