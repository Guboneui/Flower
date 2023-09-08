//
//  ThirdPartyDependency+Project.swift
//  MyPlugin
//
//  Created by 구본의 on 2023/09/09.
//

import Foundation
import ProjectDescription

extension TargetDependency {
  public struct ThirdParty { }
  public struct DesignSystem { }
}

public extension TargetDependency.ThirdParty {
  static let folderName: String = "ThirdPartyDependency"
  
  static let dependency: [TargetDependency] = [
    SnapKit,
    Then
  ]
  
  static func project(name: String) -> TargetDependency {
    return .project(
      target: "\(name)",
      path: .relativeToRoot("\(folderName)")
    )
  }
  
  static let Main = project(name: "ThirdPartyDependency")
}

extension TargetDependency.ThirdParty {
  static let SnapKit = TargetDependency.external(name: "SnapKit")
  static let Then = TargetDependency.external(name: "Then")
}
