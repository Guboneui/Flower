//
//  EmailSiginUpEmailViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/06.
//

import UIKit

import DesignSystem
import ResourceKit

import RxSwift
import SnapKit
import Then

public final class EmailSiginUpEmailViewController: UIViewController {
	private let emailSiginUpEmailView: EmailSiginUpEmailView = EmailSiginUpEmailView()
	private var navigationBar: NavigationBar { emailSiginUpEmailView.navigationBar }
	private var authCodeLabel: UILabel { emailSiginUpEmailView.authCodeLabel }
	private var resendAuthCodeLabel: UILabel { emailSiginUpEmailView.resendAuthCodeLabel }
	private var authCodeTextField: DefaultTextField { emailSiginUpEmailView.authCodeTextField }
	private var authCodeNoticeLabel: UILabel { emailSiginUpEmailView.authCodeNoticeLabel }
	private var nextButton: DefaultButton { emailSiginUpEmailView.nextButton }
	
	public override func loadView() {
		view = emailSiginUpEmailView
	}
	
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
	}
}

private extension EmailSiginUpEmailViewController {
	
	func setupGestures() {
		navigationBar.didTapLeftButton = {
			self.navigationController?.popViewController(animated: true)
		}
		
		nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
	}
	
	@objc func didTapNextButton(_ sender: UIButton) {
		if nextButton.titleLabel?.text == "인증번호 전송" {
			authCodeLabel.isHidden = false
			resendAuthCodeLabel.isHidden = false
			authCodeTextField.isHidden = false
			authCodeNoticeLabel.isHidden = false
			nextButton.setTitle("다음", for: .normal)
		} else if nextButton.titleLabel?.text == "다음" {
			if let navigation = self.navigationController as? EmailSiginUpNavigationController {
				let EmailSiginUpPasswordViewController = EmailSiginUpPasswordViewController()
				navigation.pushViewController(EmailSiginUpPasswordViewController, animated: true)
				navigation.pageController.moveToNextPage()
			}
		}
	}
}
