//
//  String+Extension.swift
//  UtilityKit
//
//  Created by 김동겸 on 1/16/24.
//

import UIKit

public extension String {
	///입력된 String의 길이를 측정하여 CGRect값으로 반환하는 함수
		func getEstimatedFrame(with font: UIFont) -> CGRect {
				let size = CGSize(width: UIScreen.main.bounds.width * 2/3, height: 1000)
				let optionss = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
				let estimatedFrame = NSString(string: self).boundingRect(
					with: size,
					options: optionss,
					attributes: [.font: font],
					context: nil
				)
				return estimatedFrame
		}
}
