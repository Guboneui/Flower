//
//  EmailSiginUpPhoneViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/08.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public class EmailSiginUpPhoneViewController: UIViewController {
	private let emailSiginUpPhoneView: EmailSiginUpPhoneView = EmailSiginUpPhoneView()
	private var navigationBar: NavigationBar { emailSiginUpPhoneView.navigationBar }
	private var nextButton: DefaultButton { emailSiginUpPhoneView.nextButton }
	
	public override func loadView() {
		view = emailSiginUpPhoneView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
	}
}

private extension EmailSiginUpPhoneViewController {
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
		self.navigationController?.popToRootViewController(animated: true)
	}
}
