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
    public struct SearchFilter { }
    public struct Main { }
    public struct Chatting { }
    public struct Map { }
  }
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

public extension TargetDependency.Feature.SearchFilter {
  static let folderName: String = "SearchFilter"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Feature/\(folderName)")
    )
  }
  
  static let Main = project(name: "SearchFilter")
}

public extension TargetDependency.Feature.Main {
  static let folderName: String = "Main"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Feature/\(folderName)")
    )
  }
  
  static let Main = project(name: "Main")
}

public extension TargetDependency.Feature.Chatting {
  static let folderName: String = "Chatting"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Feature/\(folderName)")
    )
  }
  
  static let Main = project(name: "Chatting")
}

public extension TargetDependency.Feature.Map {
  static let folderName: String = "Map"
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("Feature/\(folderName)")
    )
  }
  
  static let Main = project(name: "Map")
}