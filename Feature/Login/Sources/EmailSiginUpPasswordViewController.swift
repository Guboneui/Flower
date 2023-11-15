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
	private let navigationBar = NavigationBar(.back, title: "회원가입")
	
	private let passwordLabel: UILabel = UILabel().then {
		$0.text = "비밀번호"
		$0.font = .AppFont.Bold_16
		$0.textColor = .AppColor.appBlack
	}
	
	private let passwordTextField: DefaultTextField = DefaultTextField(.password)
	
	private let passwordConditionsLabel: UILabel = UILabel().then {
		$0.text = "영문+숫자+특수문자 8~20자리"
		$0.font = .AppFont.Regular_12
		$0.textColor = .AppColor.appGrey70
	}
	
	private let checkPasswordLabel: UILabel = UILabel().then {
		$0.text = "비밀번호 확인"
		$0.font = .AppFont.Bold_16
		$0.textColor = .AppColor.appBlack
	}
	
	private let checkPasswordTextField: DefaultTextField = DefaultTextField(.password)
	
	private let checkPasswordConditionsLabel: UILabel = UILabel().then {
		$0.text = "영문+숫자+특수문자 8~20자리"
		$0.font = .AppFont.Regular_12
		$0.textColor = .AppColor.appGrey70
	}
	
	private let nextButton: DefaultButton = DefaultButton(title: "다음", initEnableState: true)
	
	private enum Metric {
		static let horizontalMargin = 24

		static let passwordLabelTopMargin = 38
		
		static let passwordTextFieldTopMargin = 8
		
		static let passwordConditionsLabelTopMargin = 8
		static let passwordConditionsLabelRightMargin = -8
		
		static let checkPasswordLabelTopMargin = 32
		
		static let checkPasswordTextFieldTopMargin = 8
		
		static let nextButtonBottomMargin = -34
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupSubViews()
		setupGestures()
	}
	
	private func setupViews() {
		view.backgroundColor = .AppColor.appWhite
	}
	
	public func setupSubViews() {
		view.addSubview(navigationBar)
		view.addSubview(passwordLabel)
		view.addSubview(passwordTextField)
		view.addSubview(passwordConditionsLabel)
		view.addSubview(checkPasswordLabel)
		view.addSubview(checkPasswordTextField)
		view.addSubview(checkPasswordConditionsLabel)
		view.addSubview(nextButton)
		
		setupLayouts()
	}
	
	public func setupLayouts() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		passwordLabel.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.passwordLabelTopMargin)
			make.leading.equalToSuperview().offset(Metric.horizontalMargin)
		}
		
		passwordTextField.snp.makeConstraints { make in
			make.top.equalTo(passwordLabel.snp.bottom).offset(Metric.passwordTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
		
		passwordConditionsLabel.snp.makeConstraints { make in
			make.top.equalTo(passwordTextField.snp.bottom)
				.offset(Metric.passwordConditionsLabelTopMargin)
			make.trailing.equalTo(passwordTextField.snp.trailing)
				.offset(Metric.passwordConditionsLabelRightMargin)
		}
		
		checkPasswordLabel.snp.makeConstraints { make in
			make.top.equalTo(passwordConditionsLabel.snp.bottom).offset(Metric.checkPasswordLabelTopMargin)
			make.leading.equalToSuperview().offset(Metric.horizontalMargin)
		}
		
		checkPasswordTextField.snp.makeConstraints { make in
			make.top.equalTo(checkPasswordLabel.snp.bottom).offset(Metric.checkPasswordTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
		
		checkPasswordConditionsLabel.snp.makeConstraints { make in
			make.top.equalTo(checkPasswordTextField.snp.bottom)
				.offset(Metric.passwordConditionsLabelTopMargin)
			make.trailing.equalTo(checkPasswordTextField.snp.trailing)
				.offset(Metric.passwordConditionsLabelRightMargin)
		}
		
		nextButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.nextButtonBottomMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
	}
	
	public func setupGestures() {
		navigationBar.didTapLeftButton = {
			if let navigation = self.navigationController as? LoginNavigationController {
				navigation.pageController.moveToPrevPage()
			}
			self.navigationController?.popViewController(animated: true)
		}
		
		nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
	}
	
	@objc private func didTapNextButton(_ sender: UIButton) {
		if let navigation = self.navigationController as? LoginNavigationController {
			let EmailSiginUpNameViewController = EmailSiginUpNameViewController()
			navigation.pushViewController(EmailSiginUpNameViewController, animated: true)
			navigation.pageController.moveToNextPage()
		}
	}
}
