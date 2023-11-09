//
//  NetworkHelper+Project.swift
//  DesignSystemPlugin
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct NetworkHelper { }
}

public extension TargetDependency.NetworkHelper {
  static let folderName: String = "NetworkHelper"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "NetworkHelper")
}
