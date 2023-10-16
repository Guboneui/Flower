//
//  Feature+Project.swift
//  ThirdPartyDependencyPlugin
//
//  Created by 구본의 on 2023/10/16.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct Feature {
    public struct Login { }
  }
}

public extension TargetDependency.Feature {
  static let folderName: String = "Feature"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "Feature")
}

public extension TargetDependency.Feature.Login {
  static let folderName: String = "Login"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Feature/\(folderName)")
    )
  }
  
  static let Main = project(name: "Login")
}

