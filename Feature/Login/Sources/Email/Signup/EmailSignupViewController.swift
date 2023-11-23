//
//  EmailSignupViewController.swift
//  Login
//
//  Created by 김동겸 on 11/3/23.
//

import Foundation
import UIKit

import DesignSystem
import ResourceKit

import RxSwift
import SnapKit
import Then

public final class EmailSignupViewController: UIViewController {
	
	// MARK: METRIC
	private enum Metric {
		static let emailLabelTopMargin: CGFloat = 38
		static let emailLabelLeftMargin: CGFloat = 24
		
		static let emailTextFieldTopMargin: CGFloat = 8
		static let emailTextFieldBothSidesMargin: CGFloat = 24
		
		static let cautionViewHeightMargin: CGFloat = 50
		static let cautionViewTopMargin: CGFloat = 8
		
		static let cautionImageViewSize: CGFloat = 14
		static let cautionImageViewLeftMargin: CGFloat = 8

		static let cautionLabelNumberOfLines: Int = 1
		static let cautionLabelLeftMargin: CGFloat = 4
		
		static let  announcementLabelNumberOfLines: Int = 2
		static let announcementLabelTopMargin: CGFloat = 8
		static let announcementLabelLeftMargin: CGFloat = 8
		
		static let authViewDefaultAlpha: CGFloat = 0
		static let authViewShowAlpha: CGFloat = 1
		static let authViewHeightMargin: CGFloat = 131
		static let authViewTopMargin: CGFloat = 40
		static let authViewBothsidesMargin: CGFloat = 24
		
		static let authResendButtonHeightMargin: CGFloat = 12
		static let authResendButtonWidthMargin: CGFloat = 63
		static let authResendButtonRightMargin: CGFloat = 8
		static let authResendButtonBottomMargin: CGFloat = -8
		
		static let authTextFieldTopMargin: CGFloat = 8
		
		static let authCautionImageViewSize: CGFloat = 14
		static let authCautionImageViewTopMargin: CGFloat = 8
		static let authCautionImageViewLeftMargin: CGFloat = 8

		static let authCautionLabelNumberOfLines: Int = 1
		static let authCautionLabelTopMargin: CGFloat = 8
		static let authCautionLabelLeftMargin: CGFloat = 4
		
		static let authAnnouncementLabelNumberOfLines: Int = 2
		static let authAnnouncementLabelTopMargin: CGFloat = 8
		static let authAnnouncementLabelLeftMargin: CGFloat = 8
		
		static let authSendButtonBottomMargin: CGFloat = 34
		static let authSendButtonBothSidesMargin: CGFloat = 24
		
		static let tapGesturemilliseconds: Int = 300
	}
	
	// MARK: FONT
	private enum Font {
		static let emailLabelFont: UIFont = AppTheme.Font.Bold_16
		static let cautionLabelFont: UIFont = AppTheme.Font.Regular_12
		static let announcementLabelFont: UIFont = AppTheme.Font.Regular_12
		static let authLabelFont: UIFont = AppTheme.Font.Bold_16
		static let authResendButtonFont: UIFont = AppTheme.Font.Bold_10
		static let authCautionLabelFont: UIFont = AppTheme.Font.Regular_12
		static let authAnnouncementLabelFont: UIFont = AppTheme.Font.Regular_12
		static let timerLabelFont: UIFont = AppTheme.Font.Bold_10
	}
	
	// MARK: Image
	private enum Image {
		static let cautionImage: UIImage = AppTheme.Image.success
		static let authCautionImage: UIImage = AppTheme.Image.success
	}
	
	// MARK: COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.white
		static let cautionViewColor: UIColor = AppTheme.Color.white
		static let emailLabelColor: UIColor = AppTheme.Color.black
		static let cautionLabelColor: UIColor = AppTheme.Color.primary
		static let announcementLabelColor: UIColor = AppTheme.Color.grey70
		static let authViewBackgroundColor: UIColor = AppTheme.Color.white
		static let authLabelColor: UIColor = AppTheme.Color.black
		static let authResendButtonColor: UIColor = AppTheme.Color.black
		static let authCautionLabelColor: UIColor = AppTheme.Color.primary
		static let authAnnouncementLabelColor: UIColor = AppTheme.Color.grey70
		static let timerLabelColor: UIColor = AppTheme.Color.primary
	}
	
	// MARK: TEXTSET
	private enum TextSet {
		static let emailLabelText: String = "이메일"
		static let navigationBarText: String = "회원가입"
		static let cautionLabelText: String = "사용 가능한 이메일입니다"
		static let announcementLabelText: String = 
		"회원 가입시 ID는 반드시 본인 소유의 연락 가능한 이메일 주소를\n사용하여야 합니다."
		
		static let authLabelText: String = "인증번호 6자리"
		static let timerLabelText: String = "10분 00초"
		static let authTextFieldPlaceHolderText: String = "이메일 인증"
		static let authResendButtonText: String = "인증번호 재전송"
		static let authCautionLabelText: String = "사용 가능한 비밀번호입니다"
		static let authAnnouncementLabelText: String =
		"인증번호는 입력한 이메일 주소로 발송됩니다.\n수신하지 못했다면 스팸함 또는 해당 이메일 서비스의 설정을 확인해주세요."
		
		static let authSendButtonText: String = "인증번호 전송"
		static let authSendButtonDidSandText: String = "다음"
	}
	
	private let navigationBar = NavigationBar(.back, title: TextSet.navigationBarText)
	
	private let emailLabel: UILabel = UILabel().then {
		$0.text = TextSet.emailLabelText
		$0.font = Font.emailLabelFont
		$0.textColor = ColorSet.emailLabelColor
	}
	
	private let emailTextField: DefaultTextField = DefaultTextField(.email).then {
		$0.currentState = .normal
	}
	
	private let cautionView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.cautionViewColor
	}
	
	private let cautionImageView: UIImageView = UIImageView().then {
		$0.image = Image.cautionImage
	}
	
	private let cautionLabel: UILabel = UILabel().then {
		$0.text = TextSet.cautionLabelText
		$0.font = Font.cautionLabelFont
		$0.textColor = ColorSet.cautionLabelColor
		$0.numberOfLines = Metric.cautionLabelNumberOfLines
	}
	
	private let announcementLabel: UILabel = UILabel().then {
		$0.text = TextSet.announcementLabelText
		$0.font = Font.announcementLabelFont
		$0.textColor = ColorSet.announcementLabelColor
		$0.numberOfLines = Metric.announcementLabelNumberOfLines
	}
	
	private let authView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.authViewBackgroundColor
		$0.alpha = Metric.authViewDefaultAlpha
	}
	
	private let authLabel: UILabel = UILabel().then {
		$0.text = TextSet.authLabelText
		$0.font = Font.authLabelFont
		$0.textColor = ColorSet.authLabelColor
	}
	
	private let authResendButton: UIButton = UIButton().then {
		$0.setTitle(TextSet.authResendButtonText, for: .normal)
		$0.titleLabel?.font = Font.authResendButtonFont
		$0.setTitleColor(ColorSet.authResendButtonColor, for: .normal)
		$0.setUnderline()
	}
	
	private let timerLabel: UILabel = UILabel().then {
		$0.text = TextSet.timerLabelText
		$0.font = Font.timerLabelFont
		$0.textColor = ColorSet.timerLabelColor
	}
	
	private lazy var authTextField: DefaultTextField = DefaultTextField(
		.custom,
		customView: timerLabel,
		customTypePlaceHolder: TextSet.authTextFieldPlaceHolderText
	).then {
		$0.currentState = .normal
	}
	
	private let authCautionImageView: UIImageView = UIImageView().then {
		$0.image = Image.authCautionImage
	}
	
	private let authCautionLabel: UILabel = UILabel().then {
		$0.text = TextSet.authCautionLabelText
		$0.font = Font.authCautionLabelFont
		$0.textColor = ColorSet.authCautionLabelColor
		$0.numberOfLines = Metric.authCautionLabelNumberOfLines
	}
	
	private let authAnnouncementLabel: UILabel = UILabel().then {
		$0.text = TextSet.authAnnouncementLabelText
		$0.font = Font.authAnnouncementLabelFont
		$0.textColor = ColorSet.authAnnouncementLabelColor
		$0.numberOfLines = Metric.authAnnouncementLabelNumberOfLines
	}
	
	private let authSendButton: DefaultButton = DefaultButton(title: TextSet.authSendButtonText)
	
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupViews()
		setupGestures()
	}
}

private extension EmailSignupViewController {
	func setupUI() {
		view.backgroundColor = ColorSet.backgroundColor
		
		if let navigation = self.navigationController as? EmailLoginNavigationController {
			navigation.pageController.alpha = 1
			navigation.pageController.moveToFirstPage()
		}
	}
	
	func setupViews() {
		view.addSubview(navigationBar)
		
		view.addSubview(emailLabel)
		view.addSubview(emailTextField)
		
		view.addSubview(cautionView)
		cautionView.addSubview(cautionImageView)
		cautionView.addSubview(cautionLabel)
		cautionView.addSubview(announcementLabel)
		
		view.addSubview(authView)
		authView.addSubview(authLabel)
		authView.addSubview(authResendButton)
		authView.addSubview(authTextField)
		authView.addSubview(authCautionImageView)
		authView.addSubview(authCautionLabel)
		authView.addSubview(authAnnouncementLabel)
		
		view.addSubview(authSendButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		emailLabel.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.emailLabelTopMargin)
			make.leading.equalTo(emailTextField.snp.leading)
		}
		
		emailTextField.snp.makeConstraints { make in
			make.top.equalTo(emailLabel.snp.bottom).offset(Metric.emailTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.emailTextFieldBothSidesMargin)
		}
		
		cautionView.snp.makeConstraints { make in
			make.height.equalTo(Metric.cautionViewHeightMargin)
			make.top.equalTo(emailTextField.snp.bottom).offset(Metric.cautionViewTopMargin)
			make.leading.equalTo(emailTextField.snp.leading)
		}
		
		cautionImageView.snp.makeConstraints { make in
			make.height.width.equalTo(Metric.cautionImageViewSize)
			make.top.equalToSuperview()
			make.leading.equalToSuperview().offset(Metric.cautionImageViewLeftMargin)
		}
		
		cautionLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalTo(cautionImageView.snp.trailing).offset(Metric.cautionLabelLeftMargin)
		}
		
		announcementLabel.snp.makeConstraints { make in
			make.top.equalTo(cautionLabel.snp.bottom).offset(Metric.announcementLabelTopMargin)
			make.leading.equalToSuperview().offset(Metric.announcementLabelLeftMargin)
		}
		
		authView.snp.makeConstraints { make in
			make.height.equalTo(Metric.authViewHeightMargin)
			make.top.equalTo(cautionView.snp.bottom).offset(Metric.authViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.authViewBothsidesMargin)
		}
		
		authLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
		}
		
		authResendButton.snp.makeConstraints { make in
			make.height.equalTo(Metric.authResendButtonHeightMargin)
			make.width.equalTo(Metric.authResendButtonWidthMargin)
			make.bottom.equalTo(authTextField.snp.top).offset(Metric.authResendButtonBottomMargin)
			make.trailing.equalToSuperview().inset(Metric.authResendButtonRightMargin)
		}
		
		authTextField.snp.makeConstraints { make in
			make.top.equalTo(authLabel.snp.bottom).offset(Metric.authTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview()
		}
		
		authCautionImageView.snp.makeConstraints { make in
			make.height.width.equalTo(Metric.authCautionImageViewSize)
			make.top.equalTo(authTextField.snp.bottom).offset(Metric.authCautionImageViewTopMargin)
			make.leading.equalToSuperview().offset(Metric.authCautionImageViewLeftMargin)
		}
		
		authCautionLabel.snp.makeConstraints { make in
			make.top.equalTo(authTextField.snp.bottom).offset(Metric.authCautionLabelTopMargin)
			make.leading.equalTo(authCautionImageView.snp.trailing).offset(Metric.authCautionLabelLeftMargin)
		}
		
		authAnnouncementLabel.snp.makeConstraints { make in
			make.top.equalTo(authCautionLabel.snp.bottom).offset(Metric.authAnnouncementLabelTopMargin)
			make.leading.equalToSuperview().offset(Metric.authAnnouncementLabelLeftMargin)
		}
		
		authSendButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.authSendButtonBottomMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.authSendButtonBothSidesMargin)
		}
	}
	
	func setupGestures() {
		var count = 1
		
		navigationBar.rx.tapLeftButton
			.bind { [weak self] in
				guard let self else { return }
				if let navigation = self.navigationController as? EmailLoginNavigationController {
					navigation.pageController.moveToPrevPage()
					navigation.popViewController(animated: true)
				}
			}
			.disposed(by: disposeBag)
		
		authSendButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				if count == 1 {
					UIView.animate(withDuration: 1, delay: 0, animations: {
						self.authView.alpha = 1
						self.authSendButton.setTitle(TextSet.authSendButtonDidSandText, for: .normal)
					})
					count += 1
				} else if count == 2 {
					if let navigation = self.navigationController as? EmailLoginNavigationController {
						navigation.pageController.moveToNextPage()
						let secondVC = EmailSignupPWViewController()
						navigation.pushViewController(secondVC, animated: true)
					}
					self.authView.alpha = 0
					count = 1
					self.authSendButton.setTitle(TextSet.authSendButtonText, for: .normal)
				}
			}
			.disposed(by: disposeBag)
		
		authResendButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				
				print("인증번호 재발송 버튼 클릭")
			}
			.disposed(by: disposeBag)
	}
}

private extension UIButton {
	func setUnderline() {
		guard let title = title(for: .normal) else { return }
		let attributedString = NSMutableAttributedString(string: title)
		attributedString.addAttribute(.underlineStyle,
																	value: NSUnderlineStyle.single.rawValue,
																	range: NSRange(location: 0, length: title.count)
		)
		setAttributedTitle(attributedString, for: .normal)
	}
}
