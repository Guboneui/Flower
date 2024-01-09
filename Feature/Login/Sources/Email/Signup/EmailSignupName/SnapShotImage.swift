//
//  SnapShotImage.swift
//  Login
//
//  Created by 구본의 on 2024/01/01.
//

import UIKit

extension UIView {
	func snapshotImage() -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(bounds.size, true, UIScreen.main.scale)
		
		guard let currentContext = UIGraphicsGetCurrentContext() else {
			UIGraphicsEndImageContext()
			return nil
		}
		
		layer.render(in: currentContext)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		return image
	}
}
