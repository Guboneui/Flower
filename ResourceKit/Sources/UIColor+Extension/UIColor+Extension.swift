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
    
		// MARK: - White
		public static let appWhite = ResourceKitAsset.Color.white.color
		
    // MARK: - Grey
    public static let appGrey70 = ResourceKitAsset.Color.grey70.color
    public static let appGrey90 = ResourceKitAsset.Color.grey90.color
    
    // MARK: - Primary
    public static let appPrimary = ResourceKitAsset.Color.primary.color

    // MARK: - Secondary
    public static let appSecondary = ResourceKitAsset.Color.secondary.color
    
    // MARK: - Wrarning
    public static let appWarning = ResourceKitAsset.Color.warning.color
  }
}
