//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "Chatting"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    .project(
      target: "ChattingData",
      path: .relativeToRoot("Data/ChattingData")
    ),
    .project(
      target: "ThirdPartyKit",
      path: .relativeToRoot("ThirdParty/ThirdPartyKit")
    ),
    .project(
      target: "DesignSystem",
      path: .relativeToRoot("Design/DesignSystem")
    )
  ],
  ifNeedDemoApp: true
)

