//
//  EmailSiginUpNameViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/07.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class EmailSiginUpNameViewController: UIViewController {
	private let emailSiginUpNameView: EmailSiginUpNameView = EmailSiginUpNameView()
	private var navigationBar: NavigationBar { emailSiginUpNameView.navigationBar }
	private var nextButton: DefaultButton { emailSiginUpNameView.nextButton }
	
	public override func loadView() {
		 view = emailSiginUpNameView
	}
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
	}
}

private extension EmailSiginUpNameViewController {
	func setupGestures() {
		navigationBar.didTapLeftButton = {
			self.navigationController?.popViewController(animated: true)
			if let navigation = self.navigationController as? EmailSiginUpNavigationController {
				navigation.pageController.moveToPrevPage()
			}
		}
		
		nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
	}
	
	@objc func didTapNextButton(_ sender: UIButton) {
		if let navigation = self.navigationController as? EmailSiginUpNavigationController {
			let EmailSiginUpPhoneViewController = EmailSiginUpPhoneViewController()
			navigation.pushViewController(EmailSiginUpPhoneViewController, animated: true)
			navigation.pageController.moveToNextPage()
		}
	}
}
