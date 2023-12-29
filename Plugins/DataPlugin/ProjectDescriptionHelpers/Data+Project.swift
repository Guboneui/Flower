//
//  Data+Project.swift
//  ResourceKitPlugin
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct Data {
    public struct LoginData { }
    public struct ChattingData { }
  }
}

public extension TargetDependency.Data {
  static let folderName: String = "Data"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "Data")
}

public extension TargetDependency.Data.LoginData {
  static let folderName: String = "LoginData"
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Data/\(folderName)")
    )
  }
  
  static let Main = project(name: "LoginData")
}

public extension TargetDependency.Data.ChattingData {
  static let folderName: String = "ChattingData"
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Data/\(folderName)")
    )
  }
  
  static let Main = project(name: "ChattingData")
}
