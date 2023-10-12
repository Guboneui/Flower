//
//  ResourceKit+Project.swift
//  GuestHouse
//
//  Created by 구본의 on 2023/09/09.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct ResourceKit { }
}

public extension TargetDependency.ResourceKit {
  static let folderName: String = "ResourceKit"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "ResourceKit")
}
