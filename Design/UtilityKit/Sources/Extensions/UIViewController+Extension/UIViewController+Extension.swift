//
//  UIViewController+Extension.swift
//  UtilityKit
//
//  Created by 구본의 on 3/26/24.
//

import UIKit

public extension UIViewController {
	/// UIWindow의 rootViewController를 변경하여 화면전환 메소드
	func changeRootViewController(_ viewControllerToPresent: UIViewController) {
		if let window = UIApplication.shared.windows.first {
			window.rootViewController = viewControllerToPresent
			UIView.transition(
				with: window, duration: 0.5,
				options: .transitionCrossDissolve,
				animations: nil
			)
		} else {
			viewControllerToPresent.modalPresentationStyle = .overFullScreen
			self.present(viewControllerToPresent, animated: true, completion: nil)
		}
	}
}
