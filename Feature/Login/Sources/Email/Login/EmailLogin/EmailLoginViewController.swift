//
//  EmailLoginViewController.swift
//  Login
//
//  Created by 김동겸 on 10/30/23.
//

import UIKit

import DesignSystem
import ResourceKit

import RxSwift
import SnapKit
import Then

public final class EmailLoginViewController: UIViewController {
	
	// MARK: - METRIC
	private enum Metric {
		static let emailLoginLabelTopMargin: CGFloat = 32
		
		static let textFieldStackViewSpacing: CGFloat = 18
		static let textFieldStackViewTopMargin: CGFloat = 28
		static let textFieldStackViewBothSidesMargin: CGFloat = 24
		
		static let loginButtonTopMargin: CGFloat = 30
		static let loginButtonBothSidesMargin: CGFloat = 24
		
		static let idSaveCheckButtonSize: CGFloat = 16
		
		static let idSaveCheckLabelLeftMargin: CGFloat = 6
		
		static let idSaveCheckViewHeightMargin: CGFloat = 16
		static let idSaveCheckViewWidthMargin: CGFloat = 80
		static let idSaveCheckViewTopMargin: CGFloat = 16
		static let idSaveCheckViewLeftMargin: CGFloat = 28
		
		static let socialLoginsStackViewSpacing: CGFloat = 12
		static let socialLoginsStackViewBottomMargin: CGFloat = -28
		
		static let signupStackViewSpacing: CGFloat = 7
		static let signupStackViewBottomMargin: CGFloat = 30
	}
	
	// MARK: - FONT
	private enum Font {
		static let emailLoginLabelFont: UIFont = AppTheme.Font.Bold_20
		static let idSaveCheckLabelFont: UIFont = AppTheme.Font.Regular_12
		static let passwordFindButtonFont: UIFont = AppTheme.Font.Regular_12
		static let signupQuestionLabelFont: UIFont = AppTheme.Font.Regular_14
		static let emailSignupButtonFont: UIFont = AppTheme.Font.Bold_14
	}
	
	// MARK: - Image
	private enum Image {
		static let idSaveCheckButtonOffImage: UIImage = AppTheme.Image.checkBoxOff
		static let idSaveCheckButtonOnImage: UIImage = AppTheme.Image.checkBoxOn
	}
	
	// MARK: - COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.white
		static let idSaveCheckViewColor: UIColor = AppTheme.Color.white
		static let emailLoginLabelColor: UIColor = AppTheme.Color.black
		static let idSaveCheckLabelColor: UIColor = AppTheme.Color.black
		static let passwordFindButtonColor: UIColor = AppTheme.Color.black
		static let signupQuestionLabelColor: UIColor = AppTheme.Color.black
		static let emailSignupButtonColor: UIColor = AppTheme.Color.black
	}
	
	// MARK: - TEXTSET
	private enum TextSet {
		static let emailLoginLabelText: String = "이메일 로그인"
		static let loginButtonText: String = "로그인"
		static let idSaveCheckLabelText: String = "ID 저장하기"
		static let passwordFindButtonText: String = "비밀번호 찾기"
		static let signupQuestionLabelText: String = "아직 게하 회원이 아니신가요?"
		static let emailSignupButtonText: String = "이메일로 가입하기"
	}
	
	// MARK: - PRIVATE PROPERTY
	private let navigationBar = NavigationBar(.close)
	
	private let emailLoginLabel: UILabel = UILabel().then {
		$0.text = TextSet.emailLoginLabelText
		$0.font = Font.emailLoginLabelFont
		$0.textColor = ColorSet.emailLoginLabelColor
	}
	
	private lazy var textFieldStackViewSubViews: [UIView] = [
		emailTextField,
		passwordTextField
	]
	
	private lazy var textFieldStackView: UIStackView = UIStackView(
		arrangedSubviews: textFieldStackViewSubViews
	).then {
		$0.axis = .vertical
		$0.alignment = .fill
		$0.distribution = .fillEqually
		$0.spacing = Metric.textFieldStackViewSpacing
	}
	
	private let emailTextField: IconBorderTextField = IconBorderTextField(.email)
	private let passwordTextField: IconBorderTextField = IconBorderTextField(.password)
	
	private let loginButton: DefaultButton = DefaultButton(title: TextSet.loginButtonText).then {
		$0.isEnabled = false
	}
	
	private let idSaveCheckView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.idSaveCheckViewColor
	}
	
	private let idSaveCheckButton: UIButton = UIButton().then {
		$0.setImage(Image.idSaveCheckButtonOffImage, for: .normal)
	}
	
	private let idSaveCheckLabel: UILabel = UILabel().then {
		$0.text = TextSet.idSaveCheckLabelText
		$0.font = Font.idSaveCheckLabelFont
		$0.textColor = ColorSet.idSaveCheckLabelColor
	}
	
	private let passwordFindButton: UIButton = UIButton().then {
		$0.setTitle(TextSet.passwordFindButtonText, for: .normal)
		$0.titleLabel?.font = Font.passwordFindButtonFont
		$0.setTitleColor(ColorSet.passwordFindButtonColor, for: .normal)
	}
	
	private lazy var socialLoginsStackViewSubViews: [SocialLoginButton] = [
		naverLoginButton,
		kakaoLoginButton,
		appleLoginButton
	]
	
	private lazy var socialLoginsStackView: UIStackView = UIStackView(
		arrangedSubviews: socialLoginsStackViewSubViews
	).then {
		$0.axis = .horizontal
		$0.alignment = .fill
		$0.distribution = .fillEqually
		$0.spacing = Metric.socialLoginsStackViewSpacing
	}
	
	private let naverLoginButton: SocialLoginButton = SocialLoginButton(.naver)
	private let appleLoginButton: SocialLoginButton = SocialLoginButton(.apple)
	private let kakaoLoginButton: SocialLoginButton = SocialLoginButton(.kakao)
	
	private lazy var signupStackViewSubViews: [UIView] = [
		signupQuestionLabel,
		emailSignupButton
	]
	
	private lazy var signupStackView: UIStackView = UIStackView(
		arrangedSubviews: signupStackViewSubViews
	).then {
		$0.axis = .horizontal
		$0.alignment = .center
		$0.spacing = Metric.signupStackViewSpacing
	}
	
	private let signupQuestionLabel: UILabel = UILabel().then {
		$0.text = TextSet.signupQuestionLabelText
		$0.font = Font.signupQuestionLabelFont
		$0.textColor = ColorSet.signupQuestionLabelColor
		$0.textAlignment = .left
	}
	
	private let emailSignupButton: UIButton = UIButton().then {
		$0.setTitle(TextSet.emailSignupButtonText, for: .normal)
		$0.titleLabel?.font  = Font.emailSignupButtonFont
		$0.setTitleColor(ColorSet.emailSignupButtonColor, for: .normal)
	}
	
	private var emailLoginViewModel: EmailLoginViewModelInterface

	private let disposeBag = DisposeBag()
	
	// MARK: - INITIALIZE
	public init(emailLoginViewModel: EmailLoginViewModelInterface) {
		self.emailLoginViewModel = emailLoginViewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - LIFE CYCLE
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupViews()
		setupGestures()
		setupBinding()
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(false)
		if let navigation = self.navigationController as? EmailLoginNavigationController {
			navigation.pageController.alpha = 0
		}
	}
}

// MARK: - PRIVATE METHOD
private extension EmailLoginViewController {
	
	func setupUI() {
		view.backgroundColor = ColorSet.backgroundColor
		self.navigationController?.navigationBar.isHidden = true
	}
	
	func setupViews() {
		view.addSubview(navigationBar)
		
		view.addSubview(emailLoginLabel)
		view.addSubview(textFieldStackView)
		view.addSubview(loginButton)
		
		view.addSubview(idSaveCheckView)
		idSaveCheckView.addSubview(idSaveCheckButton)
		idSaveCheckView.addSubview(idSaveCheckLabel)
		
		view.addSubview(passwordFindButton)
		
		view.addSubview(socialLoginsStackView)
		view.addSubview(signupStackView)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		emailLoginLabel.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.emailLoginLabelTopMargin)
			make.leading.equalTo(textFieldStackView.snp.leading)
		}
		
		textFieldStackView.snp.makeConstraints { make in
			make.top.equalTo(emailLoginLabel.snp.bottom).offset(Metric.textFieldStackViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.textFieldStackViewBothSidesMargin)
		}
		
		loginButton.snp.makeConstraints { make in
			make.top.equalTo(textFieldStackView.snp.bottom).offset(Metric.loginButtonTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.loginButtonBothSidesMargin)
		}
		
		idSaveCheckButton.snp.makeConstraints { make in
			make.height.width.equalTo(Metric.idSaveCheckButtonSize)
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview()
		}
		
		idSaveCheckLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalTo(idSaveCheckButton.snp.trailing).offset(Metric.idSaveCheckLabelLeftMargin)
		}
		
		idSaveCheckView.snp.makeConstraints { make in
			make.height.equalTo(Metric.idSaveCheckViewHeightMargin)
			make.width.equalTo(Metric.idSaveCheckViewWidthMargin)
			make.top.equalTo(loginButton.snp.bottom).offset(Metric.idSaveCheckViewTopMargin)
			make.leading.equalToSuperview().inset(Metric.idSaveCheckViewLeftMargin)
		}
		
		passwordFindButton.snp.makeConstraints { make in
			make.centerY.equalTo(idSaveCheckButton)
			make.trailing.equalTo(loginButton)
		}
		
		socialLoginsStackView.snp.makeConstraints { make in
			make.bottom.equalTo(signupStackView.snp.top).inset(Metric.socialLoginsStackViewBottomMargin)
			make.centerX.equalToSuperview()
		}
		
		signupStackView.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.signupStackViewBottomMargin)
			make.centerX.equalToSuperview()
		}
	}
	
	func setupGestures() {
		navigationBar.rx.tapLeftButton
			.bind { [weak self] in
				guard let self else { return }
				
				self.dismiss(animated: true)
			}.disposed(by: disposeBag)
		
		emailSignupButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				
				let parentViewController = EmailLoginModalViewController()
				parentViewController.parentVC = self
				parentViewController.showModal()
			}.disposed(by: disposeBag)
		
		idSaveCheckButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				
				self.idSaveCheckButton.setImage(Image.idSaveCheckButtonOnImage, for: .normal)
			}.disposed(by: disposeBag)
		
		loginButton.rx.touchHandler()
			.bind(onNext: { [weak self] in
				guard let self else { return }
				
				self.emailLoginViewModel.fetchEmailLogin()
			}).disposed(by: disposeBag)
	}
	
	func setupBinding() {
		emailTextField.currentText
			.bind(onNext: { [weak self] emailText in
				guard let self else { return }
				
				self.emailLoginViewModel.emailRelay.accept(emailText)
				self.emailLoginViewModel.isEmailEntered.accept(!emailText.isEmpty)
			}).disposed(by: disposeBag)
		
		passwordTextField.currentText
			.bind(onNext: { [weak self] passwordText in
				guard let self else { return }
				
				self.emailLoginViewModel.passwordRelay.accept(passwordText)
				self.emailLoginViewModel.isPasswordEntered.accept(!passwordText.isEmpty)
			}).disposed(by: disposeBag)
		
		Observable.combineLatest(
			emailLoginViewModel.isEmailEntered,
			emailLoginViewModel.isPasswordEntered
		) { $0 && $1 }
			.bind(to: loginButton.rx.isEnabled)
			.disposed(by: disposeBag)
		
		emailLoginViewModel.isLoginCompleted
			.subscribe(onNext: { [weak self] isCompleted in
				guard let self else { return }
				
				//TODO 성공시: 홈화면 연결 로직, 실패시: 알림창 로직
			}).disposed(by: disposeBag)
	}
}
