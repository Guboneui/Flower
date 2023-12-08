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
		static let phoneNumberLabelFont: UIFont = AppTheme.Font.Bold_20
	}
	
	// MARK: COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.white
		static let phoneNumberLabelColor: UIColor = AppTheme.Color.black
	}
	
	// MARK: TEXTSET
	private enum TextSet {
		static let navigationBarText: String = "회원가입"
		static let phoneNumberLabelText: String = "핸드폰 번호를 입력해 주세요"
		static let completionButtonText: String = "회원가입 완료"
	}
	
	private let navigationBar = NavigationBar(.back, title: TextSet.navigationBarText)
	
	private let phoneNumberLabel: UILabel = UILabel().then {
		$0.text = TextSet.phoneNumberLabelText
		$0.font = Font.phoneNumberLabelFont
		$0.textColor = ColorSet.phoneNumberLabelColor
	}
	
	private let phoneNumberInputView = PhoneNumberInputView(
		with: ["010", "011", "116", "017", "018", "019"]
	)
	
	private let completionButton: DefaultButton = DefaultButton(title: TextSet.completionButtonText).then {
		$0.isEnabled = false
	}
		
	private let emailSignupPhoneViewModel: EmailSignupPhoneViewModel

	public init(emailSignupPhoneViewModel: EmailSignupPhoneViewModel) {
		self.emailSignupPhoneViewModel = emailSignupPhoneViewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let disposeBag = DisposeBag()

	public override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupViews()
		setupGestures()
		setupBinding()
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
		navigationBar.rx.tapLeftButton
			.bind { [weak self] in
				guard let self else { return }
				
				if let navigation = self.navigationController as? EmailLoginNavigationController {
					navigation.pageController.moveToPrevPage()
					navigation.popViewController(animated: true)
				}
			}.disposed(by: disposeBag)
		
		completionButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				
				guard let viewControllerStack = self.navigationController?.viewControllers else { return }
				for viewController in viewControllerStack {
					if let emailLoginView = viewController as? EmailLoginViewController {
						self.navigationController?.popToViewController(emailLoginView, animated: true)
					}
				}
			}.disposed(by: disposeBag)
	}
	
	func setupBinding() {
		phoneNumberInputView.isPhoneNumberComplete
			.subscribe(onNext: { [weak self] isCompleted in
				guard let self else { return }

				self.completionButton.isEnabled = isCompleted
				if isCompleted {
					if let userPhoneNumber = phoneNumberInputView.getUserPhoneNumber() {
						var phoneNumberString = ""
						phoneNumberString += userPhoneNumber.first
						phoneNumberString += userPhoneNumber.middle
						phoneNumberString += userPhoneNumber.last
						
						emailSignupPhoneViewModel.phoneNumberRelay.accept(phoneNumberString)
					}
				}
			}).disposed(by: disposeBag)
	}
}
