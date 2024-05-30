//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "LoginDomain"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    .project(
      target: "LoginEntity",
      path: .relativeToRoot("Entity/LoginEntity")
    ),
    .project(
      target: "NetworkHelper",
      path: "../../Service/NetworkHelper"
    )
  ]
)
