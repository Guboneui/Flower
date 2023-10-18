//
//  View+Extension.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/18.
//

import UIKit

public extension UIView {
  
  /// UIView의 CornerRadius를 추가합니다.
  /// - .all: 모든 모서리에 CornerRadius를 적용합니다.
  /// - .onlyTop: 상단 모서리에 CornerRadius를 적용합니다.
  /// - .onlyBottom: 하단 모서리에 CornerRadius를 적용합니다.
  /// - parameter radius: CGFloat
  /// - parameter edge: ViewCornerRadiuseType
  func makeCorderRadius(
    _ radius: CGFloat,
    edge type: ViewCornerRadiusType = .all
  ) {
    layer.masksToBounds = true
    layer.cornerRadius = radius
    switch type {
    case .onlyTop:
      layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    case .onlyBottom:
      layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    default: break
    }
  }
}
