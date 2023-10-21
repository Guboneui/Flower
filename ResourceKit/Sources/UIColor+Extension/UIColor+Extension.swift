//
//  UIColor+Extension.swift
//  ResourceKit
//
//  Created by 구본의 on 2023/09/09.
//

import UIKit

public extension UIColor {
  struct AppColor {
    // MARK: - Black
    public static let appBlack = ResourceKitAsset.Color.black.color
    
    // MARK: - Grey
    public static let appGrey100 = ResourceKitAsset.Color.grey100.color
    public static let appGrey200 = ResourceKitAsset.Color.grey200.color
    public static let appGrey700 = ResourceKitAsset.Color.grey700.color
    public static let appGrey800 = ResourceKitAsset.Color.grey800.color
    
    // MARK: - Primary
    public static let appPrimary = ResourceKitAsset.Color.primary.color
    public static let appPrimaryLight = ResourceKitAsset.Color.primaryLight.color
  }
}
