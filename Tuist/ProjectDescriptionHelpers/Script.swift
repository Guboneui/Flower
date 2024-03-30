//
//  Script.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 3/30/24.
//

import Foundation

import ProjectDescription

extension TargetScript {
  private static let lintScript = """
  ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
          
  ${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml
          
  """
  
  public static let SwiftLintScript = TargetScript.pre(
    script: lintScript,
    name: "SwiftLint",
    basedOnDependencyAnalysis: false
  )
}
