//
//  UIDevice+Extension.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/11/07.
//

import UIKit

extension UIDevice {
	public static var hasNotch: Bool {
		if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
			if let window = windowScene.windows.first {
				return window.safeAreaInsets.bottom > 0
			}
		}
		return false
	}
}
