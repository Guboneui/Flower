//
//  SecureStorageKit+Project.swift
//  DataPlugin
//
//  Created by 구본의 on 2024/02/29.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct SecureStorageKit { }
}

public extension TargetDependency.SecureStorageKit {
  static let folderName: String = "SecureStorageKit"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "SecureStorageKit")
}

