//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "ChattingData"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    .project(
      target: "ChattingDomain",
      path: .relativeToRoot("Domain/ChattingDomain")
    ),
    .project(
      target: "ChattingService",
      path: .relativeToRoot("Service/ChattingService")
    )
  ]
)

