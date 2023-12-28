//
//  EmailSiginUpEmailViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/06.
//

import UIKit

import DesignSystem
import LoginData
import LoginDomain
import LoginEntity
import ResourceKit

import RxSwift
import SnapKit
import Then

public final class EmailSiginUpEmailViewController: UIViewController {
	private let rootView: EmailSiginUpEmailView = EmailSiginUpEmailView()
	private var navigationBar: NavigationBar { rootView.navigationBar }
	private var authCodeLabel: UILabel { rootView.authCodeLabel }
	private var resendAuthCodeLabel: UILabel { rootView.resendAuthCodeLabel }
	private var emailTextField: DefaultTextField { rootView.emailTextField }
	private var authCodeTextField: DefaultTextField { rootView.authCodeTextField }
	private var authCodeNoticeLabel: UILabel { rootView.authCodeNoticeLabel }
	private var sendAuthCodeButton: DefaultButton { rootView.sendAuthCodeButton }
	private var nextButton: DefaultButton { rootView.nextButton }
	private var emailStateView: UIView { rootView.emailStateView }
	private var emailStateImageView: UIImageView { rootView.emailStateImageView }
	private var emailStateLabel: UILabel { rootView.emailStateLabel }
	private var authCodeStateView: UIView { rootView.authCodeStateView }
	private var authCodeStateImageView: UIImageView { rootView.authCodeStateImageView }
	private var authCodeStateLabel: UILabel { rootView.authCodeStateLabel }
	private var authCodeView: UIView { rootView.authCodeView }
	
	public override func loadView() {
		view = rootView
	}
	let siginUpRepository: SiginUpRepository = SiginUpRepository()
	lazy var siginUpUseCase: SiginUpUseCaseInterface = SiginUpUseCase(siginUpRepository: siginUpRepository)
	private lazy var viewModel = EmailSiginUpEmailViewModel(siginUpUseCase: siginUpUseCase)
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
		setupBindings()
	}
}

private extension EmailSiginUpEmailViewController {
	func setupGestures() {
		navigationBar.rx.tapLeftButton
			.bind { [weak self] in
				guard let self else { return }
				if let navigation = self.navigationController as? EmailSiginUpNavigationController {
					navigation.popViewController(animated: true)
				}
			}.disposed(by: disposeBag)
		
		sendAuthCodeButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				self.viewModel.sendAuthCodeMethod(
					params: SendAuthCodeRequestDTO(email: self.emailTextField.currentText.value)
				)
				//TODO: emailTextField 입력 막기
				self.authCodeView.isHidden = false
				self.sendAuthCodeButton.isHidden = true
			}.disposed(by: disposeBag)
		
		nextButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				if let navigation = self.navigationController as? EmailSiginUpNavigationController {
					let emailSiginUpPasswordViewController = EmailSiginUpPasswordViewController()
					navigation.pushViewController(emailSiginUpPasswordViewController, animated: true)
					navigation.pageController.moveToNextPage()
				}
			}.disposed(by: disposeBag)
		
		resendAuthCodeLabel.rx.tapGesture()
			.when(.recognized)
			.throttle(.milliseconds(300),
								latest: false,
								scheduler: MainScheduler.instance)
			.bind { [weak self] _ in
				guard let self else { return }
				self.viewModel.sendAuthCodeMethod(params: SendAuthCodeRequestDTO(email: self.emailTextField.currentText.value))
			}.disposed(by: disposeBag)
	}
	
	func setupBindings() {
		//이메일
		emailTextField.currentText
			.subscribe(onNext: { [weak self] text in
				guard let self else { return }
				if !text.isEmpty {
					self.viewModel.emailConfirmMethod(params: EmailConfirmRequestDTO(email: text))
					viewModel.setEmailConfirm()
					emailStateView.isHidden = false
				} else {
					emailStateView.isHidden = true
					emailTextField.currentState = .normal
				}
			}).disposed(by: disposeBag)
		
		viewModel.emailConfirmState
			.subscribe(onNext: { [weak self] result in
				guard let self else { return }
				self.emailStateLabel.text = result.emailConfirmLabel
				if result.emailConfirmSuccess {
					self.emailTextField.currentState = .success
					self.emailStateImageView.image = AppTheme.Image.success
					self.emailStateLabel.textColor = AppTheme.Color.primary
					self.sendAuthCodeButton.isEnabled = true
				} else {
					self.emailTextField.currentState = .failure
					self.emailStateImageView.image = AppTheme.Image.caution
					self.emailStateLabel.textColor = AppTheme.Color.warning
					self.sendAuthCodeButton.isEnabled = false
				}
			}).disposed(by: disposeBag)
		
		//인증번호
		authCodeTextField.currentText
			.subscribe(onNext: { [weak self] text in
				guard let self else { return }
				if !text.isEmpty {
					self.viewModel.authCodeConfirmMethod(params: AuthCodeConfirmRequestDTO(
						email: emailTextField.currentText.value,
						code: text
					))
					viewModel.setAuthCode()
					authCodeStateView.isHidden = false
				} else {
					authCodeStateView.isHidden = true
					emailTextField.currentState = .normal
				}
			}).disposed(by: disposeBag)
		
			viewModel.authCodeConfirmState
			.subscribe(onNext: { [weak self] result in
				guard let self else { return }
				print(result)
				self.authCodeStateLabel.text = result.authCodeConfirmLabel
				if result.authCodeConfirmSuccess {
					self.authCodeTextField.currentState = .success
					self.authCodeStateImageView.image = AppTheme.Image.success
					self.authCodeStateLabel.textColor = AppTheme.Color.primary
					self.nextButton.isEnabled = true
				} else {
					self.authCodeTextField.currentState = .failure
					self.authCodeStateImageView.image = AppTheme.Image.caution
					self.authCodeStateLabel.textColor = AppTheme.Color.warning
					self.nextButton.isEnabled = false
				}
			}).disposed(by: disposeBag)
	}
}
