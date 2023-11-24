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
		
		static let pwCautionImageViewSize: CGFloat = 14
		static let pwCautionImageViewTopMargin: CGFloat = 8
		static let pwCautionImageViewLeftMargin: CGFloat = 8
		
		static let pwCautionLabelTopMargin: CGFloat = 8
		static let pwCautionLabelLeftMargin: CGFloat = 4
		
		static let pwAnnouncementLabelRightMargin: CGFloat = 9
		
		static let pwCheckViewHeightMargin: CGFloat = 93
		static let pwCheckViewTopMargin: CGFloat = 38
		static let pwCheckViewBothSidesMargin: CGFloat = 24
		
		static let pwCheckTextFieldTopMargin: CGFloat = 8
		
		static let pwCheckAnnouncementLabelTopMargin: CGFloat = 8
		static let pwCheckAnnouncementLabelRightMargin: CGFloat = 9
		
		static let nextButtonBottomMargin: CGFloat = 34
		static let nextButttonBothsides: CGFloat = 24
		
		static let pwCautionLabelNumberOfLines: Int = 1
		static let pwAnnouncementLabelNumberOfLines: Int = 1
	}
	
	// MARK: FONT
	private enum Font {
		static let pwLabelFont: UIFont = AppTheme.Font.Bold_16
		static let pwCautionLabelFont: UIFont = AppTheme.Font.Regular_12
		static let pwAnnouncementLabelFont: UIFont = AppTheme.Font.Regular_12
		static let pwCheckAnnouncementLabelFont: UIFont = AppTheme.Font.Regular_12
	}
	
	// MARK: Image
	private enum Image {
		static let pwCautionImage: UIImage = AppTheme.Image.success
	}
	
	// MARK: COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.white
		static let pwViewBackgroundColor: UIColor = AppTheme.Color.white
		static let pwCheckViewBackgroundColor: UIColor = AppTheme.Color.white
		static let pwLabelColor: UIColor = AppTheme.Color.black
		static let pwCautionLabelColor: UIColor = AppTheme.Color.primary
		static let pwAnnouncementLabelColor: UIColor = AppTheme.Color.grey70
		static let pwCheckAnnouncementLabelColor: UIColor = AppTheme.Color.grey70
	}
	
	// MARK: TEXTSET
	private enum TextSet {
		static let navigationBarText: String = "회원가입"
		static let pwLabelText: String = "비밀번호"
		static let pwCheckLabelText: String = "비밀번호 확인"
		static let pwCautionLabelText: String = "사용가능한 비밀번호 입니다"
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
	
	private let pwCautionLabel: UILabel = UILabel().then {
		$0.text = TextSet.pwCautionLabelText
		$0.font = Font.pwCautionLabelFont
		$0.textColor = ColorSet.pwCautionLabelColor
		$0.numberOfLines = Metric.pwCautionLabelNumberOfLines
	}
	
	private let pwCautionImageView: UIImageView = UIImageView().then {
		$0.image = Image.pwCautionImage
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
	
	private let pwCheckAnnouncementLabel: UILabel = UILabel().then {
		$0.text = TextSet.pwCheckAnnouncementLabelText
		$0.font = Font.pwCheckAnnouncementLabelFont
		$0.textColor = ColorSet.pwCheckAnnouncementLabelColor
		$0.numberOfLines = Metric.pwAnnouncementLabelNumberOfLines
	}
	
	private let nextButton: DefaultButton = DefaultButton(title: TextSet.nextButtonText)
	
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupViews()
		setupGestures()
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
		pwView.addSubview(pwCautionImageView)
		pwView.addSubview(pwCautionLabel)
		pwView.addSubview(pwAnnouncementLabel)
		
		view.addSubview(pwCheckView)
		pwCheckView.addSubview(pwCheckLabel)
		pwCheckView.addSubview(pwCheckTextField)
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
		
		pwCautionImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.pwCautionImageViewSize)
			make.top.equalTo(pwTextField.snp.bottom).offset(Metric.pwCautionImageViewTopMargin)
			make.leading.equalToSuperview().inset(Metric.pwCautionImageViewLeftMargin)
		}
		
		pwCautionLabel.snp.makeConstraints { make in
			make.top.equalTo(pwTextField.snp.bottom).offset(Metric.pwCautionLabelTopMargin)
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
}
