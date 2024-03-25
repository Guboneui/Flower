//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "AppData"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    .project(
      target: "AppDomain",
      path: .relativeToRoot("Domain/AppDomain")
    ),
    .project(
      target: "AppService",
      path: .relativeToRoot("Service/AppService")
    ),
    .project(
      target: "LoginData",
      path: "../LoginData"
    ),
    .project(
      target: "MapData",
      path: "../MapData"
    ),
    .project(
      target: "ChattingData",
      path: "../ChattingData"
    )
  ]
)
