//
//  EmailSignupPWViewController.swift
//  Login
//
//  Created by 김동겸 on 11/7/23.
//

import Foundation
import UIKit

import DesignSystem
import ResourceKit

import RxSwift
import SnapKit
import Then

public final class EmailSignupPWViewController: UIViewController {
	// MARK: METRIC
	private enum Metric {
		static let pwViewHeightMargin: CGFloat = 93
		static let pwViewTopMargin: CGFloat = 38
		static let pwViewBothSidesMargin: CGFloat = 24
		
		static let pwTextFieldTopMargin: CGFloat = 8
		
		static let pwCautionViewHeightMargin: CGFloat = 14
		static let pwCautionViewTopMargin: CGFloat = 8
		
		static let pwCautionImageViewSize: CGFloat = 14
		static let pwCautionImageViewLeftMargin: CGFloat = 8
		
		static let pwCautionLabelLeftMargin: CGFloat = 4
		
		static let pwAnnouncementLabelRightMargin: CGFloat = 9
		
		static let pwCheckViewHeightMargin: CGFloat = 93
		static let pwCheckViewTopMargin: CGFloat = 38
		static let pwCheckViewBothSidesMargin: CGFloat = 24
		
		static let pwCheckTextFieldTopMargin: CGFloat = 8
		
		static let pwCheckCautionViewHeightMargin: CGFloat = 14
		static let pwCheckCautionViewTopMargin: CGFloat = 8
		
		static let pwCheckCautionImageViewSize: CGFloat = 14
		static let pwCheckCautionImageViewLeftMargin: CGFloat = 8
		
		static let pwCheckCautionLabelLeftMargin: CGFloat = 4
		
		static let pwCheckAnnouncementLabelTopMargin: CGFloat = 8
		static let pwCheckAnnouncementLabelRightMargin: CGFloat = 9
		
		static let nextButtonBottomMargin: CGFloat = 34
		static let nextButttonBothsides: CGFloat = 24
		
		static let pwCautionLabelNumberOfLines: Int = 1
		static let pwCheckCautionLabelNumberOfLines: Int = 1
		static let pwAnnouncementLabelNumberOfLines: Int = 1
	}
	
	// MARK: FONT
	private enum Font {
		static let pwLabelFont: UIFont = AppTheme.Font.Bold_16
		static let pwCautionLabelFont: UIFont = AppTheme.Font.Regular_12
		static let pwCheckCautionLabelFont: UIFont = AppTheme.Font.Regular_12
		static let pwAnnouncementLabelFont: UIFont = AppTheme.Font.Regular_12
		static let pwCheckAnnouncementLabelFont: UIFont = AppTheme.Font.Regular_12
	}
	
	// MARK: Image
	private enum Image {
		static let pwCautionSuccessImage: UIImage = AppTheme.Image.success
		static let pwCautionFailureImage: UIImage = AppTheme.Image.caution
		
		static let pwCheckCautionSuccessImage: UIImage = AppTheme.Image.success
		static let pwCheckCautionFailureImage: UIImage = AppTheme.Image.caution
	}
	
	// MARK: COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.white
		static let pwViewBackgroundColor: UIColor = AppTheme.Color.white
		static let pwCheckViewBackgroundColor: UIColor = AppTheme.Color.white
		static let pwLabelColor: UIColor = AppTheme.Color.black
		
		static let pwCautionViewColor: UIColor = AppTheme.Color.white
		static let pwCautionLabelSuccessColor: UIColor = AppTheme.Color.primary
		static let pwCautionLabelFailureColor: UIColor = AppTheme.Color.warning
		
		static let pwCheckCautionViewColor: UIColor = AppTheme.Color.white
		static let pwCheckCautionLabelSuccessColor: UIColor = AppTheme.Color.primary
		static let pwCheckCautionLabelFailureColor: UIColor = AppTheme.Color.warning

		static let pwAnnouncementLabelColor: UIColor = AppTheme.Color.grey70
		static let pwCheckAnnouncementLabelColor: UIColor = AppTheme.Color.grey70
	}
	
	// MARK: TEXTSET
	private enum TextSet {
		static let navigationBarText: String = "회원가입"
		static let pwLabelText: String = "비밀번호"
		static let pwCheckLabelText: String = "비밀번호 확인"
		
		static let pwCautionLabelSuccessText: String = "사용가능한 비밀번호 입니다"
		static let pwCautionLabelFailureText: String = "특수문자를 포함해 주세요"
		
		static let pwCheckCautionLabelSuccessText: String = "사용가능한 비밀번호 입니다"
		static let pwCheckCautionLabelFailureText: String = "비밀번호가 일치하지 않습니다"
		
		static let pwAnnouncementLabelText: String = "영문+숫자+특수문자 8~20자리"
		static let pwCheckAnnouncementLabelText: String = "영문+숫자+특수문자 8~20자리"
		static let nextButtonText: String = "다음"
	}
	
	private let navigationBar = NavigationBar(.back, title: TextSet.navigationBarText)
	
	private let pwView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.pwViewBackgroundColor
	}
	
	private let pwLabel: UILabel = UILabel().then {
		$0.text = TextSet.pwLabelText
		$0.font = Font.pwLabelFont
		$0.textColor = ColorSet.pwLabelColor
	}
	
	private let pwTextField: DefaultTextField = DefaultTextField(.password).then {
		$0.currentState = .normal
	}
	
	private let pwCautionView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.pwCautionViewColor
		$0.alpha = 0
	}
	
	private let pwCautionImageView: UIImageView = UIImageView().then {
		$0.image = Image.pwCautionFailureImage
	}
	
	private let pwCautionLabel: UILabel = UILabel().then {
		$0.text = TextSet.pwCautionLabelFailureText
		$0.font = Font.pwCautionLabelFont
		$0.textColor = ColorSet.pwCautionLabelFailureColor
		$0.numberOfLines = Metric.pwCautionLabelNumberOfLines
	}
	
	private let pwAnnouncementLabel: UILabel = UILabel().then {
		$0.text = TextSet.pwAnnouncementLabelText
		$0.font = Font.pwAnnouncementLabelFont
		$0.textColor = ColorSet.pwAnnouncementLabelColor
		$0.numberOfLines = Metric.pwAnnouncementLabelNumberOfLines
	}
	
	private let pwCheckView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.pwCheckViewBackgroundColor
	}
	
	private let pwCheckLabel: UILabel = UILabel().then {
		$0.text = TextSet.pwCheckLabelText
		$0.font = Font.pwLabelFont
		$0.textColor = ColorSet.pwLabelColor
	}
	
	private let pwCheckTextField: DefaultTextField = DefaultTextField(.password).then {
		$0.currentState = .normal
	}
	
	private let pwCheckCautionView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.pwCheckCautionViewColor
		$0.alpha = 0
	}
	
	private let pwCheckCautionImageView: UIImageView = UIImageView().then {
		$0.image = Image.pwCheckCautionFailureImage
	}
	
	private let pwCheckCautionLabel: UILabel = UILabel().then {
		$0.text = TextSet.pwCheckCautionLabelFailureText
		$0.font = Font.pwCheckCautionLabelFont
		$0.textColor = ColorSet.pwCheckCautionLabelFailureColor
		$0.numberOfLines = Metric.pwCheckCautionLabelNumberOfLines
	}
	
	private let pwCheckAnnouncementLabel: UILabel = UILabel().then {
		$0.text = TextSet.pwCheckAnnouncementLabelText
		$0.font = Font.pwCheckAnnouncementLabelFont
		$0.textColor = ColorSet.pwCheckAnnouncementLabelColor
		$0.numberOfLines = Metric.pwAnnouncementLabelNumberOfLines
	}
	
	private let nextButton: DefaultButton = DefaultButton(title: TextSet.nextButtonText).then {
		$0.isEnabled = false
	}
	
	private let disposeBag: DisposeBag = DisposeBag()
	
	private let emailSignupPWViewModel: EmailSignupPWViewModel

	public init(emailSignupPWViewModel: EmailSignupPWViewModel) {
		self.emailSignupPWViewModel = emailSignupPWViewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupViews()
		setupGestures()
		setupBinding()
	}
}

private extension EmailSignupPWViewController {
	func setupUI() {
		view.backgroundColor = ColorSet.backgroundColor
	}
	
	func setupViews() {
		view.addSubview(navigationBar)
		
		view.addSubview(pwView)
		pwView.addSubview(pwLabel)
		pwView.addSubview(pwTextField)
		
		pwView.addSubview(pwCautionView)
		pwCautionView.addSubview(pwCautionImageView)
		pwCautionView.addSubview(pwCautionLabel)
		
		pwView.addSubview(pwAnnouncementLabel)
		
		view.addSubview(pwCheckView)
		pwCheckView.addSubview(pwCheckLabel)
		pwCheckView.addSubview(pwCheckTextField)
		
		pwCheckView.addSubview(pwCheckCautionView)
		pwCheckCautionView.addSubview(pwCheckCautionImageView)
		pwCheckCautionView.addSubview(pwCheckCautionLabel)
		
		pwCheckView.addSubview(pwCheckAnnouncementLabel)
		
		view.addSubview(nextButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		pwView.snp.makeConstraints { make in
			make.height.equalTo(Metric.pwViewHeightMargin)
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.pwViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.pwViewBothSidesMargin)
		}
		
		pwLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
		}
		
		pwTextField.snp.makeConstraints { make in
			make.top.equalTo(pwLabel.snp.bottom).offset(Metric.pwTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview()
		}
		
		pwCautionView.snp.makeConstraints { make in
			make.height.equalTo(Metric.pwCautionViewHeightMargin)
			make.top.equalTo(pwTextField.snp.bottom).offset(Metric.pwCautionViewTopMargin)
			make.leading.equalToSuperview()
		}
		
		pwCautionImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.pwCautionImageViewSize)
			make.top.equalToSuperview()
			make.leading.equalToSuperview().inset(Metric.pwCautionImageViewLeftMargin)
		}
		
		pwCautionLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalTo(pwCautionImageView.snp.trailing).offset(Metric.pwCautionLabelLeftMargin)
		}
		
		pwAnnouncementLabel.snp.makeConstraints { make in
			make.centerY.equalTo(pwCautionLabel)
			make.trailing.equalToSuperview().inset(Metric.pwAnnouncementLabelRightMargin)
		}
		
		pwCheckView.snp.makeConstraints { make in
			make.height.equalTo(Metric.pwCheckViewHeightMargin)
			make.top.equalTo(pwView.snp.bottom).offset(Metric.pwCheckViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.pwCheckViewBothSidesMargin)
		}
		
		pwCheckLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
		}
		
		pwCheckTextField.snp.makeConstraints { make in
			make.top.equalTo(pwCheckLabel.snp.bottom).offset(Metric.pwCheckTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview()
		}
		
		pwCheckCautionView.snp.makeConstraints { make in
			make.height.equalTo(Metric.pwCheckCautionViewHeightMargin)
			make.top.equalTo(pwCheckTextField.snp.bottom)
				.offset(Metric.pwCheckCautionViewTopMargin)
			make.leading.equalToSuperview()
		}
		
		pwCheckCautionImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.pwCheckCautionImageViewSize)
			make.top.equalToSuperview()
			make.leading.equalToSuperview().inset(Metric.pwCheckCautionImageViewLeftMargin)
		}
		
		pwCheckCautionLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalTo(pwCheckCautionImageView.snp.trailing)
				.offset(Metric.pwCheckCautionLabelLeftMargin)
		}
		
		pwCheckAnnouncementLabel.snp.makeConstraints { make in
			make.top.equalTo(pwCheckTextField.snp.bottom).offset(Metric.pwCheckAnnouncementLabelTopMargin)
			make.trailing.equalToSuperview().inset(Metric.pwCheckAnnouncementLabelRightMargin)
		}
		
		nextButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.nextButtonBottomMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.nextButttonBothsides)
		}
	}
	
	func setupGestures() {
		
		navigationBar.rx.tapLeftButton
			.bind { [weak self] in
				guard let self else { return }
				
				if let navigation = self.navigationController as? EmailLoginNavigationController {
					navigation.pageController.moveToPrevPage()
					navigation.popViewController(animated: true)
				}
			}
			.disposed(by: disposeBag)
		
		nextButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				
				if let navigation = self.navigationController as? EmailLoginNavigationController {
					navigation.pageController.moveToNextPage()
					
					let signupNameVC = EmailSignupNameViewController()
					navigation.pushViewController(signupNameVC, animated: true)
				}
			}
			.disposed(by: disposeBag)
	}
	
	func setupBinding() {
		pwTextField.currentText
			.bind(onNext: { [weak self] pwText in
				guard let self else { return }
				
				self.emailSignupPWViewModel.pwRelay.accept(pwText)
				
				if pwText.isEmpty {
					self.emailSignupPWViewModel.pwBool.accept(nil)
				} else {
						self.emailSignupPWViewModel.isValiedPW()
				}
			}).disposed(by: disposeBag)
		
		pwCheckTextField.currentText
			.bind(onNext: { [weak self] pwCheckText in
				guard let self else { return }
				
				self.emailSignupPWViewModel.pwCheckRelay.accept(pwCheckText)
				
				if pwCheckText.isEmpty {
					self.emailSignupPWViewModel.pwCheckBool.accept(nil)
				} else {
						self.emailSignupPWViewModel.isValiedPWCheck()
				}
			}).disposed(by: disposeBag)
		
		emailSignupPWViewModel.pwBool
			.subscribe(onNext: { [weak self] bool in
				guard let self else { return }
							
				setPWTextFieldState(bool: bool)
				
			}).disposed(by: disposeBag)
		
		emailSignupPWViewModel.pwCheckBool
			.subscribe(onNext: { [weak self] bool in
				guard let self else { return }
							
				setPWCheckTextFieldState(bool: bool)
				nextButton.isEnabled = bool ?? false

			}).disposed(by: disposeBag)
	}
	
	func setPWTextFieldState(bool: Bool?) {
		if bool == true {
			pwCautionView.alpha = 1
			
			pwTextField.currentState = .success
			pwCautionLabel.text = TextSet.pwCautionLabelSuccessText
			pwCautionLabel.textColor = ColorSet.pwCautionLabelSuccessColor
			pwCautionImageView.image = Image.pwCautionSuccessImage
		} else if bool == false {
			pwCautionView.alpha = 1
			
			pwTextField.currentState = .failure
			pwCautionLabel.text = TextSet.pwCautionLabelFailureText
			pwCautionLabel.textColor = ColorSet.pwCautionLabelFailureColor
			pwCautionImageView.image = Image.pwCautionFailureImage
		} else {
			pwCautionView.alpha = 0
			pwTextField.currentState = .normal
		}
	}
	
	func setPWCheckTextFieldState(bool: Bool?) {
		if bool == true {
			pwCheckCautionView.alpha = 1
			
			pwCheckTextField.currentState = .success
			pwCheckCautionLabel.text = TextSet.pwCheckCautionLabelSuccessText
			pwCheckCautionLabel.textColor = ColorSet.pwCheckCautionLabelSuccessColor
			pwCheckCautionImageView.image = Image.pwCheckCautionSuccessImage
			
		} else if bool == false {
			pwCheckCautionView.alpha = 1
			
			pwCheckTextField.currentState = .failure
			pwCheckCautionLabel.text = TextSet.pwCheckCautionLabelFailureText
			pwCheckCautionLabel.textColor = ColorSet.pwCheckCautionLabelFailureColor
			pwCheckCautionImageView.image = Image.pwCheckCautionFailureImage
		} else {
			pwCheckCautionView.alpha = 0
			pwCheckTextField.currentState = .normal
		}
	}
}
