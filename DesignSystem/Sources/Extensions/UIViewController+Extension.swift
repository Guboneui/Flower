//
//  UIViewController+Extension.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/30.
//

import UIKit

// MARK: - 키보드 관련 UIViewController Extension
public extension UIViewController {
	
	/// UIViewController에서 keyboardHeight가 필요한 경우 접근할 수 있는 타입 프로퍼티입니다.
	static var keyboardHeight: CGFloat = 0.0
	
	/// viewDidLoad에서 해당 함수를 선언합니다.
	/// 선언 후, Self.keyboardHeight 변수에 접근할 경우, 현재 화면에서 키보드 높이를 가져올 수 있습니다.
	func registerKeyboardObserver() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
	}
	
	@objc private func keyboardWillShow(notification: NSNotification) {
		if let keyboardFrame: NSValue = notification.userInfo?[
			UIResponder.keyboardFrameEndUserInfoKey
		] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			Self.keyboardHeight = keyboardRectangle.height
		}
	}
	
	@objc private func keyboardWillHide(notification: NSNotification) {
		Self.keyboardHeight = 0.0
	}
}
