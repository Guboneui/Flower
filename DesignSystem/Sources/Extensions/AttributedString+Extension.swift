//
//  AttributedString+Extension.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/11/07.
//

import UIKit

import ResourceKit

public extension AttributedString {
	
	/// AttributedString을 반환하는 함수입니다.
	/// 원하는 텍스트와, 폰트를 적용할 수 있습니다.
	static func makeAttributedStringWithFont(
		text: String,
		font: UIFont = .AppFont.Regular_12
	) -> AttributedString {
		
		let attributes: [NSAttributedString.Key: Any] = [
			.font: font
		]
		
		let attributedString = NSAttributedString(
			string: text,
			attributes: attributes
		)
		
		return AttributedString(attributedString)
	}
}
