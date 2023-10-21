//
//  UIFont+Extension.swift
//  ResourceKit
//
//  Created by 구본의 on 2023/09/09.
//

import UIKit

public extension UIFont {
  struct AppFont {
    // MARK: - Weight 400
    public static let Regular_12 = ResourceKitFontFamily.Pretendard.regular.font(size: 12)
    public static let Regular_14 = ResourceKitFontFamily.Pretendard.regular.font(size: 14)
    public static let Regular_16 = ResourceKitFontFamily.Pretendard.regular.font(size: 16)
    
    // MARK: - Weight 700
    public static let Bold_10 = ResourceKitFontFamily.Pretendard.bold.font(size: 10)
    public static let Bold_14 = ResourceKitFontFamily.Pretendard.bold.font(size: 14)
    public static let Bold_16 = ResourceKitFontFamily.Pretendard.bold.font(size: 16)
    public static let Bold_20 = ResourceKitFontFamily.Pretendard.bold.font(size: 20)
  }
}
