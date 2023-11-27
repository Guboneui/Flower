//
//  EmailSiginUpPasswordViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/07.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class EmailSiginUpPasswordViewController: UIViewController {
	private let emailSiginUpPasswordView: EmailSiginUpPasswordView = EmailSiginUpPasswordView()
	private var navigationBar: NavigationBar {emailSiginUpPasswordView.navigationBar }
	private var nextButton: DefaultButton {emailSiginUpPasswordView.nextButton }
	
	public override func loadView() {
		view = emailSiginUpPasswordView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
	}
}

private extension EmailSiginUpPasswordViewController {
	func setupGestures() {
		navigationBar.didTapLeftButton = {
			if let navigation = self.navigationController as? EmailSiginUpNavigationController {
				navigation.pageController.moveToPrevPage()
			}
			self.navigationController?.popViewController(animated: true)
		}
		
		nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
	}
	
	@objc func didTapNextButton(_ sender: UIButton) {
		if let navigation = self.navigationController as? EmailSiginUpNavigationController {
			let EmailSiginUpNameViewController = EmailSiginUpNameViewController()
			navigation.pushViewController(EmailSiginUpNameViewController, animated: true)
			navigation.pageController.moveToNextPage()
		}
	}
}
