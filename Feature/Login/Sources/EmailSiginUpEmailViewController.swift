//
//  EmailSiginUpEmailViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/06.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

import RxSwift

public final class EmailSiginUpEmailViewController: UIViewController {
	
	private let navigationBar = NavigationBar(.back, title: "회원가입")
	
	private let emailLabel: UILabel = UILabel().then {
		$0.text = "이메일"
		$0.font = .AppFont.Bold_16
		$0.textColor = .AppColor.appBlack
	}
	
	private let emailTextField: DefaultTextField = DefaultTextField(.email)
	
	private let cautionLabel: UILabel = UILabel().then {
		$0.text = "회원 가입시 ID는 반드시 본인 소유의 연락 가능한 이메일 주소를 사용하여야 합니다."
		$0.font = .AppFont.Regular_12
		$0.textColor = .AppColor.appGrey70
		$0.numberOfLines = 0
	}
	
	private let authCodeLabel: UILabel = UILabel().then {
		$0.text = "인증번호 6자리"
		$0.font = .AppFont.Bold_16
		$0.textColor = .AppColor.appBlack
	}
	
	private let resendAuthCodeLabel: UILabel = UILabel().then {
		let attributedString = NSMutableAttributedString.init(string: "인증번호 재전송")
		attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange
				.init(location: 0, length: attributedString.length))
		$0.attributedText = attributedString
		$0.font = .AppFont.Bold_10
		$0.textColor = .AppColor.appBlack
	}
	
	private let authCodeTextField: DefaultTextField = DefaultTextField(.emailAuthCode)
	
	private let authCodeNoticeLabel: UILabel = UILabel().then {
		$0.text = "인증번호는 입력한 이메일 주소로 발송됩니다. 수신하지 못했다면 스팸함 또는 해당 이메일 서비스의 설정을 확인해주세요."
		$0.font = .AppFont.Regular_12
		$0.textColor = .AppColor.appGrey70
		$0.numberOfLines = 0
	}
	
	private let nextButton: DefaultButton = DefaultButton(title: "인증번호 전송", initEnableState: true)
	
	private enum Metric {
		static let horizontalMargin = 24

		static let emailLabelTopMargin = 38
		static let emailTextFieldTopMargin = 8
		
		static let cautionLabelTopMargin = 30
		static let cautionLabelLeftMargin = 8
		
		static let authCodeLabelTopMargin = 32
		
		static let resendAuthCodeLabelTopMargin = 7
		static let resendAuthCodeLabelRightMargin = -32
		
		static let authCodeTextFieldTopMargin = 8
		
		static let authCodeNoticeLabelTopMargin = 30
		static let authCodeNoticeLabelHorzontalMargin = 32
		
		static let nextButtonBottomMargin = -34
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupSubViews()
		setupGestures()
		
		authCodeLabel.isHidden = true
		resendAuthCodeLabel.isHidden = true
		authCodeTextField.isHidden = true
		authCodeNoticeLabel.isHidden = true
	}
	
	private func setupViews() {
		view.backgroundColor = .AppColor.appWhite
	}
	
	private func setupSubViews() {
		view.addSubview(navigationBar)
		view.addSubview(emailLabel)
		view.addSubview(emailTextField)
		view.addSubview(cautionLabel)
		view.addSubview(authCodeLabel)
		view.addSubview(resendAuthCodeLabel)
		view.addSubview(authCodeTextField)
		view.addSubview(authCodeNoticeLabel)
		view.addSubview(nextButton)
		
		setupLayouts()
	}
	
	private func setupLayouts() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		emailLabel.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.emailLabelTopMargin)
			make.leading.equalToSuperview().offset(Metric.horizontalMargin)
		}
		
		emailTextField.snp.makeConstraints { make in
			make.top.equalTo(emailLabel.snp.bottom).offset(Metric.emailTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
		
		cautionLabel.snp.makeConstraints { make in
			make.top.equalTo(emailTextField.snp.bottom).offset(Metric.cautionLabelTopMargin)
			make.leading.equalTo(emailTextField.snp.leading).offset(Metric.cautionLabelLeftMargin)
			make.trailing.equalToSuperview().offset(-Metric.horizontalMargin)
		}
		
		authCodeLabel.snp.makeConstraints { make in
			make.top.equalTo(cautionLabel.snp.bottom).offset(Metric.authCodeLabelTopMargin)
			make.leading.equalToSuperview().offset(Metric.horizontalMargin)
		}
		
		resendAuthCodeLabel.snp.makeConstraints { make in
			make.top.equalTo(authCodeLabel.snp.top).offset(Metric.resendAuthCodeLabelTopMargin)
			make.trailing.equalToSuperview().offset(Metric.resendAuthCodeLabelRightMargin)
		}
		
		authCodeTextField.snp.makeConstraints { make in
			make.top.equalTo(authCodeLabel.snp.bottom).offset(Metric.authCodeTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
		
		authCodeNoticeLabel.snp.makeConstraints { make in
			make.top.equalTo(authCodeTextField.snp.bottom).offset(Metric.authCodeNoticeLabelTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.authCodeNoticeLabelHorzontalMargin)
		}
		
		nextButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.nextButtonBottomMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
	}
	
	private func setupGestures() {
		navigationBar.didTapLeftButton = {
			self.navigationController?.popViewController(animated: true)
		}
		
		nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
	}
	
	@objc private func didTapNextButton(_ sender: UIButton) {
		if nextButton.titleLabel?.text == "인증번호 전송" {
			authCodeLabel.isHidden = false
			resendAuthCodeLabel.isHidden = false
			authCodeTextField.isHidden = false
			authCodeNoticeLabel.isHidden = false
			
			nextButton.setTitle("다음", for: .normal)
		} else if nextButton.titleLabel?.text == "다음" {
			if let navigation = self.navigationController as? LoginNavigationController {
				let EmailSiginUpPasswordViewController = EmailSiginUpPasswordViewController()
				navigation.pushViewController(EmailSiginUpPasswordViewController, animated: true)
				navigation.pageController.moveToNextPage()
			}
		}
	}
}
