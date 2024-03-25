//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "AppDomain"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    .project(
      target: "AppEntity",
      path: .relativeToRoot("Entity/AppEntity")
    ),
    .project(
      target: "LoginDomain",
      path: "../LoginDomain"
    ),
    .project(
      target: "MapDomain",
      path: "../MapDomain"
    ),
    .project(
      target: "ChattingDomain",
      path: "../ChattingDomain"
    )
  ]
)
