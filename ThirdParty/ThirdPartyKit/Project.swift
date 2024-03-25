//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/23/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = "ThirdPartyKit"

let project: Project = Project.featureFramework(
  name: name,
  packages: [
    .package(
      url: "https://github.com/realm/realm-swift",
      .upToNextMajor(from: "10.42.0")
    )
  ],
  dependencies: [
    // MARK: - External Dependency
    .external(name: "SocketIO"),
    .external(name: "SnapKit"),
    .external(name: "RxSwift"),
    .external(name: "RxGesture"),
    .external(name: "ReactorKit"),
    .external(name: "Nuke"),
    .external(name: "Then"),
    .external(name: "NMapsMap"),
    .external(name: "HorizonCalendar"),
    
    // MARK: - Package Dependency
    .package(product: "RealmSwift"),
  ]
)
