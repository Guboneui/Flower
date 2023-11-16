//
//  EmailSignupPhoneViewController.swift
//  Login
//
//  Created by 김동겸 on 11/8/23.
//

import Foundation
import UIKit

import DesignSystem
import ResourceKit

import RxGesture
import RxSwift
import SnapKit
import Then

public final class EmailSignupPhoneViewController: UIViewController {
	// MARK: METRIC
	private enum Metric {
		static let phoneNumberLabelTopMargin: CGFloat = 54
		static let phoneNumberLabelLeftMargin: CGFloat = 24
		
		static let phoneNumberInputViewTopMargin: CGFloat = 36
		static let phoneNumberInputViewBothsides: CGFloat = 22
		
		static let completionButtonBottomMargin: CGFloat = 34
		static let completionButtonBothsides: CGFloat = 24
		
		static let tapGesturemilliseconds: Int = 300
	}
	
	// MARK: FONT
	private enum Font {
		static let phoneNumberLabelFont: UIFont = .AppFont.Bold_20
	}
	
	// MARK: COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = .AppColor.appWhite
		static let phoneNumberLabelColor: UIColor = .AppColor.appBlack
	}
	
	// MARK: TEXTSET
	private enum TextSet {
		static let navigationBarText: String = "회원가입"
		static let phoneNumberLabelText: String = "핸드폰 번호를 입력해 주세요"
		static let nextButtonText: String = "다음"
	}
	
	private let navigationBar = NavigationBar(.back, title: TextSet.navigationBarText)
	
	private let phoneNumberLabel: UILabel = UILabel().then {
		$0.text = TextSet.phoneNumberLabelText
		$0.font = Font.phoneNumberLabelFont
		$0.textColor = ColorSet.phoneNumberLabelColor
	}
	
	private let phoneNumberInputView = PhoneNumberInputView(
		with: ["010", "116", "017", "011", "018", "019"]
	)
	
	private let completionButton: DefaultButton = DefaultButton(title: TextSet.nextButtonText)
	
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupViews()
		setupGestures()
	}
}

private extension EmailSignupPhoneViewController {
	func setupUI() {
		view.backgroundColor = ColorSet.backgroundColor
	}
	
	func setupViews() {
		view.addSubview(navigationBar)
		view.addSubview(phoneNumberLabel)
		view.addSubview(phoneNumberInputView)
		view.addSubview(completionButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		phoneNumberLabel.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.phoneNumberLabelTopMargin)
			make.leading.equalToSuperview().inset(Metric.phoneNumberLabelLeftMargin)
		}
		
		phoneNumberInputView.snp.makeConstraints { make in
			make.top.equalTo(phoneNumberLabel.snp.bottom).offset(Metric.phoneNumberInputViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.phoneNumberInputViewBothsides)
		}
		
		completionButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.completionButtonBottomMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.completionButtonBothsides)
		}
	}
	
	func setupGestures() {
		navigationBar.didTapLeftButton = {
			if let navigation = self.navigationController as? EmailLoginNavigationController {
				navigation.pageController.moveToPrevPage()
				navigation.popViewController(animated: true)
			}
		}
		
		completionButton.rx.tap
			.throttle(.milliseconds(Metric.tapGesturemilliseconds), latest: false,
								scheduler: MainScheduler.instance
			)
			.bind { [weak self] in
				guard let self else { return }
				guard let viewControllerStack = self.navigationController?.viewControllers else { return }
				for viewController in viewControllerStack {
					if let emailLoginView = viewController as? EmailLoginViewController {
						self.navigationController?.popToViewController(emailLoginView, animated: true)
					}
				}
			}
			.disposed(by: disposeBag)
	}
}
