//
//  UserKit+Project.swift
//  EntityPlugin
//
//  Created by 구본의 on 2024/03/15.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct UserKit { }
}

public extension TargetDependency.UserKit {
  static let folderName: String = "UserKit"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "UserKit")
}

