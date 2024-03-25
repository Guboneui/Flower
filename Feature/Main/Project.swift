//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "Main"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    .project(
      target: "Chatting",
      path: "../Chatting"
    ),
    .project(
      target: "Map",
      path: "../Map"
    ),
    .project(
      target: "Profile",
      path: "../Profile"
    ),
    .project(
      target: "SearchFilter",
      path: "../SearchFilter"
    ),
    .project(
      target: "DesignSystem",
      path: .relativeToRoot("Design/DesignSystem")
    )
  ],
  ifNeedDemoApp: true
)

