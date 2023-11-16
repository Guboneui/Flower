//
//  EmailLoginViewController.swift
//  Login
//
//  Created by 김동겸 on 10/30/23.
//

import UIKit

import DesignSystem
import ResourceKit

import RxGesture
import RxSwift
import SnapKit
import Then

public final class EmailLoginViewController: UIViewController {
	
	// MARK: METRIC
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
		
		static let tapGesturemilliseconds: Int = 300
	}
	
	// MARK: FONT
	private enum Font {
		static let emailLoginLabelFont: UIFont = .AppFont.Bold_20
		static let idSaveCheckLabelFont: UIFont = .AppFont.Regular_12
		static let passwordFindButtonFont: UIFont = .AppFont.Regular_12
		static let signupQuestionLabelFont: UIFont = .AppFont.Regular_14
		static let emailSignupButtonFont: UIFont = .AppFont.Bold_14
	}
	
	// MARK: Image
	private enum Image {
		static let idSaveCheckButtonOffImage: UIImage = .AppImage.checkBoxOff
		static let idSaveCheckButtonOnImage: UIImage = .AppImage.checkBoxOn
	}
	
	// MARK: COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = .AppColor.appWhite
		static let idSaveCheckViewColor: UIColor = .AppColor.appWhite
		static let emailLoginLabelColor: UIColor = .AppColor.appBlack
		static let idSaveCheckLabelColor: UIColor = .AppColor.appBlack
		static let passwordFindButtonColor: UIColor = .AppColor.appBlack
		static let signupQuestionLabelColor: UIColor = .AppColor.appBlack
		static let emailSignupButtonColor: UIColor = .AppColor.appBlack
	}
	
	// MARK: TEXTSET
	private enum TextSet {
		static let emailLoginLabelText: String = "이메일 로그인"
		static let loginButtonText: String = "로그인"
		static let idSaveCheckLabelText: String = "ID 저장하기"
		static let passwordFindButtonText: String = "비밀번호 찾기"
		static let signupQuestionLabelText: String = "아직 게하 회원이 아니신가요?"
		static let emailSignupButtonText: String = "이메일로 가입하기"
	}
	
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
	private let passwordTextField: IconBorderTextField = IconBorderTextField(
		.password
	)
	
	private let loginButton: DefaultButton = DefaultButton(title: TextSet.loginButtonText)
	
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
	
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupViews()
		setupGestures()
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(false)
		if let navigation = self.navigationController as? EmailLoginNavigationController {
			navigation.pageController.alpha = 0
		}
	}
}

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
		navigationBar.didTapLeftButton = {
			self.dismiss(animated: true)
		}
		
		emailSignupButton.rx.tap
			.throttle(.milliseconds(Metric.tapGesturemilliseconds), latest: false,
								scheduler: MainScheduler.instance
			)
			.bind {[weak self] in guard let self else { return }
				let parentViewController = EmailLoginModalViewController()
				parentViewController.parentVC = self
				parentViewController.showModal()
			}
			.disposed(by: disposeBag)
		
		idSaveCheckButton.rx.tap
			.throttle(.milliseconds(Metric.tapGesturemilliseconds), latest: false,
								scheduler: MainScheduler.instance
			)
			.bind {[weak self] in guard let self else { return }
				print("자동 로그인 체크 버튼 클릭")
				idSaveCheckButton.setImage(Image.idSaveCheckButtonOnImage, for: .normal)
			}
			.disposed(by: disposeBag)
	}
}
