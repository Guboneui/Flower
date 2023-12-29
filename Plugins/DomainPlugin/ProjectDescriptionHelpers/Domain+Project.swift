//
//  Domain+Project.swift
//  ResourceKitPlugin
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct Domain {
    public struct LoginDomain { }
    public struct ChattingDomain { }
    public struct MapDomain { }
  }
}

public extension TargetDependency.Domain {
  static let folderName: String = "Domain"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "Domain")
}

public extension TargetDependency.Domain.LoginDomain {
  static let folderName: String = "LoginDomain"
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Domain/\(folderName)")
    )
  }
  
  static let Main = project(name: "LoginDomain")
}

public extension TargetDependency.Domain.ChattingDomain {
  static let folderName: String = "ChattingDomain"
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Domain/\(folderName)")
    )
  }
  
  static let Main = project(name: "ChattingDomain")
}

public extension TargetDependency.Domain.MapDomain {
  static let folderName: String = "MapDomain"
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Domain/\(folderName)")
    )
  }
  
  static let Main = project(name: "MapDomain")
}
