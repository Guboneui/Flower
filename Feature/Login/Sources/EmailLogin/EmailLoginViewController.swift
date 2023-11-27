//
//  EmailLoginViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/01.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class EmailLoginViewController: UIViewController {
	private let emailLoginView: EmailLoginView = EmailLoginView()
	private var headerSlideView: HeaderSlideView { emailLoginView.headerSlideView }
	private var navigationBar: NavigationBar { emailLoginView.navigationBar }
	private var loginButton: DefaultButton { emailLoginView.loginButton }
	private var saveIdentifierCheckBox: UIButton { emailLoginView.saveIdentifierCheckBox }
	private var saveIdentifierView: UIView { emailLoginView.saveIdentifierView }
	private var emailSiginUpButton: UIButton { emailLoginView.emailSiginUpButton }
	
	public override func loadView() {
		view = emailLoginView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		if let navigation = self.navigationController as? EmailSiginUpNavigationController {
			navigation.pageController.isHidden = true
			navigation.pageController.moveToFirstPage()
		}
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		if let navigation = self.navigationController as? EmailSiginUpNavigationController {
			navigation.pageController.isHidden = false
		}
	}
}

private extension EmailLoginViewController {
	func setupGestures() {
		navigationBar.didTapLeftButton = { [weak self] in
			guard let self else { return }
			dismiss(animated: true)
		}
		
		saveIdentifierView.addGestureRecognizer(UITapGestureRecognizer(
			target: self,
			action: #selector(didTapCheckBox(_:))))
		
		loginButton.addAction(.init(handler: { [weak self] _ in
				guard let self else { return }
				didTabLoginButton()
			}), for: .touchUpInside)
		
		emailSiginUpButton.addAction(UIAction(handler: { [weak self] _ in
				guard let self else { return }
				didTapEmailSiginUp()
			}), for: .touchUpInside)
	}
	
	@objc func didTapCheckBox(_ sender: UITapGestureRecognizer) {
		saveIdentifierCheckBox.isSelected.toggle()
	}
	
	@objc func didTabLoginButton() {
		headerSlideView.startAnimation(at: self)
	}
	
	@objc func didTapEmailSiginUp() {
		let SiginUpTermsViewController: SiginUpTermsViewController = SiginUpTermsViewController()
		SiginUpTermsViewController.parentVC = self
		SiginUpTermsViewController.showModal()
	}
}
