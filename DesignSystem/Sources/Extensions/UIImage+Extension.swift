//
//  UIImage+Extension.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/11/07.
//

import UIKit

public extension UIImage {
	/// 이미지 적용 시, 크기를 변경해 적요합니다.
	/// 버튼에 이미지를 추가하는 경우 사용됩니다.
	func changeImageSize(size: CGSize) -> UIImage? {
		let frame = CGRect(origin: CGPoint.zero, size: size)
		UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
		self.draw(in: frame)
		let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		self.withRenderingMode(.alwaysOriginal)
		return resizedImage
	}
}
