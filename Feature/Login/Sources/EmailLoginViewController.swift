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
	private let headerSlideView = HeaderSlideView(.loginError)
	
	private let navigationBar = NavigationBar(.close)
	
	private let emailLoginLabel: UILabel = UILabel().then {
		$0.text = "이메일 로그인"
		$0.font = .AppFont.Bold_20
		$0.textColor = .AppColor.appBlack
	}
	
	private let emailTextField: IconBorderTextField = IconBorderTextField(.email)
	private let passwordTextField: IconBorderTextField = IconBorderTextField(.password)
	private let loginButton: DefaultButton = DefaultButton(title: "로그인", initEnableState: true)
	
	private let saveIdentifierCheckBox: UIButton = UIButton().then {
		$0.setImage(.AppImage.checkBoxOff, for: .normal)
		$0.setImage(.AppImage.checkBoxOn, for: .selected)
	}
	
	private let saveIdentifierLabel: UILabel = UILabel().then {
		$0.text = "이메일 기억하기"
		$0.font = .AppFont.Regular_12
		$0.textColor = .AppColor.appBlack
	}
	
	private let saveIdentifierView: UIView = UIView()
	
	private let findPasswordLabel: UILabel = UILabel().then {
		$0.text = "비밀번호 찾기"
		$0.font = .AppFont.Regular_12
		$0.textColor = .AppColor.appBlack
	}
	
	private lazy var stackViewSubViews: [SocialLoginButton] = [
		naverLoginButton,
		appleLoginButton,
		kakaoLoginButton
	]
	
	private lazy var loginStackView: UIStackView = UIStackView(
		arrangedSubviews: stackViewSubViews
	).then {
		$0.distribution = .equalSpacing
	}
	
	private let naverLoginButton: SocialLoginButton = SocialLoginButton(.naver)
	private let kakaoLoginButton: SocialLoginButton = SocialLoginButton(.kakao)
	private let appleLoginButton: SocialLoginButton = SocialLoginButton(.apple)
	
	private let siginUpStackView: UIStackView = UIStackView().then {
		$0.spacing = 7
	}
	
	private let siginUpLabel: UILabel = UILabel().then {
		$0.text = "아직 게하 회원이 아니신가요?"
		$0.font = .AppFont.Regular_14
		$0.textColor = .AppColor.appBlack
	}
	
	private let emailSiginUpButton: UIButton = UIButton().then {
		$0.setTitle("이메일로 가입하기", for: .normal)
		$0.setTitleColor(.AppColor.appBlack, for: .normal)
		$0.titleLabel?.font = .AppFont.Bold_14
	}
	
	private enum Metric {
		static let emailLoginLabelTopMargin = 24
		static let emailLoginLabelLeftMargin = 24
		
		static let loginTextFieldHorzontalMargin = 24
		static let emailTextFieldTopMargin = 28
		static let passwordTextFieldTopMargin = 18
		
		static let loginButtonTopMargin = 30
		static let loginButtonHorzontalMargin = 24
		
		static let saveIdentifierCheckBoxSize = 16
		static let saveIdentifierCheckBoxTopMargin = 12
		static let saveIdentifierCheckBoxLeftMargin = 4
		
		static let saveIdentifierLabelLeftMargin = 8
		
		static let findPasswordLabelRightMargin = -4
		
		static let loginStackViewInset = 103
		static let loginStackViewBottomMargin = -28
		
		static let siginUpStackViewBottomMargin = -30
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupSubViews()
		setupGestures()
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		if let navigation = self.navigationController as? LoginNavigationController {
			navigation.pageController.isHidden = false
		}
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		if let navigation = self.navigationController as? LoginNavigationController {
			navigation.pageController.isHidden = true
			navigation.pageController.moveToFirstPage()
		}
	}
	
	private func setupViews() {
		view.backgroundColor = .AppColor.appWhite
	}
	
	private func setupSubViews() {
		view.addSubview(navigationBar)
		view.addSubview(emailLoginLabel)
		view.addSubview(emailTextField)
		view.addSubview(passwordTextField)
		view.addSubview(loginButton)
		view.addSubview(saveIdentifierCheckBox)
		view.addSubview(saveIdentifierLabel)
		view.addSubview(saveIdentifierView)
		view.addSubview(findPasswordLabel)
		view.addSubview(loginStackView)
		view.addSubview(siginUpStackView)
		
		siginUpStackView.addArrangedSubview(siginUpLabel)
		siginUpStackView.addArrangedSubview(emailSiginUpButton)
		
		setupLayouts()
	}
	
	private func setupLayouts() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		emailLoginLabel.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.emailLoginLabelTopMargin)
			make.leading.equalToSuperview().offset(Metric.emailLoginLabelLeftMargin)
		}
		
		emailTextField.snp.makeConstraints { make in
			make.top.equalTo(emailLoginLabel.snp.bottom).offset(Metric.emailTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.loginTextFieldHorzontalMargin)
		}
		
		passwordTextField.snp.makeConstraints { make in
			make.top.equalTo(emailTextField.snp.bottom).offset(Metric.passwordTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.loginTextFieldHorzontalMargin)
		}
		
		loginButton.snp.makeConstraints { make in
			make.top.equalTo(passwordTextField.snp.bottom).offset(Metric.loginButtonTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.loginButtonHorzontalMargin)
		}
		
		saveIdentifierCheckBox.snp.makeConstraints { make in
			make.size.equalTo(Metric.saveIdentifierCheckBoxSize)
			make.top.equalTo(loginButton.snp.bottom).offset(Metric.saveIdentifierCheckBoxTopMargin)
			make.leading.equalTo(loginButton.snp.leading).offset(Metric.saveIdentifierCheckBoxLeftMargin)
		}
		
		saveIdentifierLabel.snp.makeConstraints { make in
			make.centerY.equalTo(saveIdentifierCheckBox.snp.centerY)
			make.leading.equalTo(saveIdentifierCheckBox.snp.trailing)
				.offset(Metric.saveIdentifierLabelLeftMargin)
		}
		
		saveIdentifierView.snp.makeConstraints { make in
			make.top.equalTo(saveIdentifierCheckBox.snp.top)
			make.bottom.equalTo(saveIdentifierCheckBox.snp.bottom)
			make.leading.equalTo(saveIdentifierCheckBox.snp.leading)
			make.trailing.equalTo(saveIdentifierLabel.snp.trailing)
		}
		
		findPasswordLabel.snp.makeConstraints { make in
			make.centerY.equalTo(saveIdentifierCheckBox.snp.centerY)
			make.trailing.equalTo(loginButton.snp.trailing).offset(Metric.findPasswordLabelRightMargin)
		}
		
		siginUpStackView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.siginUpStackViewBottomMargin)
		}
		
		loginStackView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(Metric.loginStackViewInset)
			make.bottom.equalTo(siginUpLabel.snp.top).offset(Metric.loginStackViewBottomMargin)
		}
	}
	
	private func setupGestures() {
		navigationBar.didTapLeftButton = {
			self.dismiss(animated: true)
			self.view.window?.rootViewController = LoginViewController()
			self.view.window?.makeKeyAndVisible()
		}
		
		saveIdentifierView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox(_:))))
		loginButton.addTarget(self, action: #selector(didTabLoginButton(_:)), for: .touchUpInside)
		emailSiginUpButton.addTarget(self, action: #selector(didTapEmailSiginUp(_:)), for: .touchUpInside)
	}
	
	@objc private func didTapCheckBox(_ sender: UITapGestureRecognizer) {
		saveIdentifierCheckBox.isSelected.toggle()
	}
	
	@objc private func didTabLoginButton(_ sender: UIButton) {
		headerSlideView.startAnimation(at: self)
	}
	
	@objc private func didTapEmailSiginUp(_ sender: UIButton) {
		let SiginUpTermsViewController = SiginUpTermsViewController()
		SiginUpTermsViewController.parentVC = self
		SiginUpTermsViewController.showModal()
		let nav = LoginNavigationController(rootViewController: self)
		self.view.window?.rootViewController = nav
				nav.navigationBar.isHidden = true
		self.view.window?.makeKeyAndVisible()
	}
}
