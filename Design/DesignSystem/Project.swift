//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "DesignSystem"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    .project(
      target: "ResourceKit",
      path: "../ResourceKit"
    ),
    .project(
      target: "UtilityKit",
      path: "../UtilityKit"
    ),
    // MARK: - External Dependency
    .external(name: "SnapKit"),
    .external(name: "RxSwift"),
    .external(name: "RxGesture"),
    .external(name: "Nuke"),
    .external(name: "Then")
  ]
)

