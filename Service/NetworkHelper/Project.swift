//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/25/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "NetworkHelper"

let project: Project = Project.featureLibrary(
  name: name,
  dependencies: [
    // MARK: - Dependency
    .project(
      target: "UserStorageKit",
      path: .relativeToRoot("Storage/UserStorageKit")
    ),
    .project(
      target: "SecureStorageKit",
      path: .relativeToRoot("Storage/SecureStorageKit")
    ),
    // MARK: - External Dependency
    .external(name: "Moya"),
    .external(name: "RxMoya")
  ]
)
