//
//  UtilityKit+Project.swift
//  DataPlugin
//
//  Created by 구본의 on 2023/12/26.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct UtilityKit { }
}

public extension TargetDependency.UtilityKit {
  static let folderName: String = "UtilityKit"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "UtilityKit")
}
