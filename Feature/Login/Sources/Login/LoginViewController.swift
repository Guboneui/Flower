//
//  LoginViewController.swift
//  Login
//
//  Created by 구본의 on 2023/10/17.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class LoginViewController: UIViewController {
	private let loginView: LoginView = LoginView()
	private var emailLoginButton: SocialLoginButton { loginView.emailLoginButton }
	
	public override func loadView() {
		 view = loginView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
	}
}

private extension LoginViewController {
	func setupGestures() {
		emailLoginButton.addTarget(self, action: #selector(didTapEmailLogin(_:)), for: .touchUpInside)
	}
	
	@objc private func didTapEmailLogin(_ sender: UIButton) {
		let EmailLoginViewController = EmailLoginViewController()
		let emailSiginUpNavi = EmailSiginUpNavigationController(
							rootViewController: EmailLoginViewController
						)
		emailSiginUpNavi.modalPresentationStyle = UIModalPresentationStyle.fullScreen
		present(emailSiginUpNavi, animated: true, completion: nil)
	}
}
