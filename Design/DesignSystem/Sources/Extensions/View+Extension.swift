//
//  View+Extension.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/18.
//

import UIKit

import ResourceKit

public extension UIView {

	//MARK: - CornerRadius

	/// UIView의 CornerRadius를 추가합니다.
	/// - .all: 모든 모서리에 CornerRadius를 적용합니다.
	/// - .onlyTop: 상단 모서리에 CornerRadius를 적용합니다.
	/// - .onlyBottom: 하단 모서리에 CornerRadius를 적용합니다.
	/// - parameter radius: CGFloat
	/// - parameter edge: ViewCornerRadiuseType
	func makeCornerRadius(
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

	/// UIView의 Border를 추가합니다.
	/// - parameter width: CGFloat
	/// - parameter color: UIColor
	func makeBorder(
		borderWidth: CGFloat = 1.0,
		borderColor: UIColor = AppTheme.Color.neutral100
	) {
		layer.masksToBounds = true
		layer.borderWidth = borderWidth
		layer.borderColor = borderColor.cgColor
	}

	/// UIView의 CornerRadius와 Border를 함께 추가합니다.
	/// - parameter radius: CGFloat
	/// - parameter width: CGFloat
	/// - parameter color: UIColor
	func makeCornerRadiusWithBorder(
		_ radius: CGFloat,
		borderWidth: CGFloat = 1.0,
		borderColor: UIColor = AppTheme.Color.neutral100
	) {
		layer.masksToBounds = true
		layer.cornerRadius = radius
		layer.borderWidth = borderWidth
		layer.borderColor = borderColor.cgColor
	}

	//MARK: - Shadow

	/// - Parameters:
	///   - color: 색
	///   - opacity: 투명도 (0 to 1)
	///   - offset: 위치
	///   - radius: 퍼짐효과
	///
	func makeShadow(
		color: UIColor = AppTheme.Color.neutral900,
		opacity: Float = 0.2,
		offset: CGSize = CGSize(width: 1, height: 1),
		radius: CGFloat = 20
	) {
		layer.masksToBounds = false
		layer.shadowColor = color.cgColor
		layer.shadowOpacity = opacity
		layer.shadowOffset = offset
		layer.shadowRadius = radius
	}
}
