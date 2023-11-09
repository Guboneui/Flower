//
//  DesignSystem+Project.swift
//  ThirdPartyDependencyPlugin
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct Entity {
    public struct LoginEntity { }
  }
}

public extension TargetDependency.Entity {
  static let folderName: String = "Entity"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "Entity")
}

public extension TargetDependency.Entity.LoginEntity {
  static let folderName: String = "LoginEntity"
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Entity/\(folderName)")
    )
  }
  
  static let Main = project(name: "LoginEntity")
}
