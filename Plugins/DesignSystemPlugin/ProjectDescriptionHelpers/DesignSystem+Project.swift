//
//  DesignSystem+Project.swift
//  ThirdPartyDependencyPlugin
//
//  Created by 구본의 on 2023/10/17.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct DesignSystem { }
}

public extension TargetDependency.DesignSystem {
  static let folderName: String = "DesignSystem"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "DesignSystem")
}

