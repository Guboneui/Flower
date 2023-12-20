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
	// MARK: - METRIC
	private enum Metric {
		static let phoneNumberLabelTopMargin: CGFloat = 54
		static let phoneNumberLabelLeftMargin: CGFloat = 24
		
		static let phoneNumberInputViewTopMargin: CGFloat = 36
		static let phoneNumberInputViewBothsides: CGFloat = 22
		
		static let completionButtonBottomMargin: CGFloat = 34
		static let completionButtonBothsides: CGFloat = 24
	}
	
	// MARK: - FONT
	private enum Font {
		static let phoneNumberLabelFont: UIFont = AppTheme.Font.Bold_20
	}
	
	// MARK: - COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.white
		static let phoneNumberLabelColor: UIColor = AppTheme.Color.black
	}
	
	// MARK: - TEXTSET
	private enum TextSet {
		static let navigationBarText: String = "회원가입"
		static let phoneNumberLabelText: String = "핸드폰 번호를 입력해 주세요"
		static let completionButtonText: String = "회원가입 완료"
		static let failureAlertTitleText: String = "회원가입 실패"
		static let failureAlertMessageText: String = "서버 오류"
		static let failureAlertBtnTitleText: String = "닫기"
	}
	
	// MARK: - PRIVATE PROPERTY
	private let navigationBar = NavigationBar(.back, title: TextSet.navigationBarText)
	
	private let phoneNumberLabel: UILabel = UILabel().then {
		$0.text = TextSet.phoneNumberLabelText
		$0.font = Font.phoneNumberLabelFont
		$0.textColor = ColorSet.phoneNumberLabelColor
	}
	
	private let phoneNumberInputView = PhoneNumberInputView(
		with: ["010", "011", "116", "017", "018", "019"]
	)
	
	private let completionButton: DefaultButton = DefaultButton(
		title: TextSet.completionButtonText).then {
			$0.isEnabled = false
		}
	
	private var emailSignupPhoneViewModel: EmailSignupPhoneViewModelInterface
	
	private let disposeBag = DisposeBag()
	
	// MARK: - INITIALIZE
	public init(emailSignupPhoneViewModel: EmailSignupPhoneViewModelInterface) {
		self.emailSignupPhoneViewModel = emailSignupPhoneViewModel
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
		self.addKeyboardNotifications()
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		self.removeKeyboardNotifications()
	}
}

// MARK: - PRIVATE METHOD
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
				
				let userSignupDTO = self.emailSignupPhoneViewModel.userSignupDTO
				self.emailSignupPhoneViewModel.fetchEmailSignup(userSignupDTO: userSignupDTO)
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
						
						emailSignupPhoneViewModel.userSignupDTO.phoneNum = phoneNumberString
					}
				}
			}).disposed(by: disposeBag)
		
		emailSignupPhoneViewModel.isSignupCompletionRelay
			.compactMap { $0 }
			.subscribe(onNext: { [weak self] isCompleted in
				guard let self else { return }
								
				if isCompleted == true {
					// MARK: - TODO 홈화면으로 바로 이동하는 로직으로 변경
					let alert = UIAlertController(
						title: "회원가입 완료", message: "이메일 로그인 화면으로 이동합니다", preferredStyle: .alert)
					let success = UIAlertAction(title: "확인", style: .default) { _ in
						guard let viewControllerStack = self.navigationController?.viewControllers else { return }
						for viewController in viewControllerStack {
							if let emailLoginView = viewController as? EmailLoginViewController {
								self.navigationController?.popToViewController(emailLoginView, animated: true)
							}
						}
					}
					alert.addAction(success)
					present(alert, animated: true)
				} else if isCompleted == false {
					let alert = UIAlertController(
						title: TextSet.failureAlertTitleText,
						message: TextSet.failureAlertMessageText,
						preferredStyle: .alert
					)
					let failure = UIAlertAction(
						title: TextSet.failureAlertBtnTitleText,
						style: .default) { _ in
						self.emailSignupPhoneViewModel.isSignupCompletionRelay.accept(nil)
					}
					alert.addAction(failure)
					present(alert, animated: true)
				}
			}).disposed(by: disposeBag)
	}
	
	// MARK: - Notification METHOD
	func addKeyboardNotifications() {
		NotificationCenter.default.addObserver(
			self, selector: #selector(self.keyboardWillShow(_:)),
			name: UIResponder.keyboardWillShowNotification, object: nil
		)
		
		NotificationCenter.default.addObserver(
			self, selector: #selector(self.keyboardWillHide(_:)),
			name: UIResponder.keyboardWillHideNotification, object: nil
		)
	}
	
	func removeKeyboardNotifications() {
		NotificationCenter.default.removeObserver(
			self, name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
		
		NotificationCenter.default.removeObserver(
			self, name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
	}
	
	@objc func keyboardWillShow(_ noti: NSNotification) {
		if let keyboardFrame: NSValue =
				noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			let keyboardHeight = keyboardRectangle.height
			
			completionButton.snp.updateConstraints { make in
				make.bottom.equalTo(self.view.safeAreaLayoutGuide)
					.inset(Metric.completionButtonBottomMargin + keyboardHeight)
			}
		}
	}
	
	@objc func keyboardWillHide(_ noti: NSNotification) {
		completionButton.snp.updateConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide)
				.inset(Metric.completionButtonBottomMargin)
		}
	}
}
