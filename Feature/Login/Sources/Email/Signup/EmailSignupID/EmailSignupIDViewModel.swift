//
//  EmailSignupViewModel.swift
//  Login
//
//  Created by 김동겸 on 11/24/23.
//

import Foundation

import LoginDomain
import LoginEntity

import RxRelay
import RxSwift

public protocol EmailSignupIDViewModelInterface {
	var emailRelay: BehaviorRelay<String> { get }
	var authRelay: BehaviorRelay<String> { get }
	var currentViewState: BehaviorRelay<EmailSignupIDViewStateModel> { get }
	var userData: UserData { get set }

	func isValidEmail()
	func isValiedAuthNumber()
	func fetchEmailAuth(email: String)
}

public final class EmailSignupIDViewModel: EmailSignupIDViewModelInterface {
	public var emailRelay: BehaviorRelay<String> = .init(value: "")
	public var authRelay: BehaviorRelay<String> = .init(value: "")
	public var currentViewState: BehaviorRelay<EmailSignupIDViewStateModel> =
		.init(value: EmailSignupIDViewStateModel(state: .email))
	
	public var userData: UserData = .init()

	// MARK: - Private Property
	private let signUpUseCase: EmailSignupIDUseCaseInterface
	private let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
	private let disposeBag: DisposeBag
	
	public init(useCase: EmailSignupIDUseCaseInterface) {
		self.signUpUseCase = useCase
		self.disposeBag = .init()
	}
	
	public func isValidEmail() {
		if currentViewState.value.state == .email {
			if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailRelay.value) {
				fetchEmailConfirm(email: emailRelay.value)
			} else {
				currentViewState.accept(.init(state: .email, enabled: false))
			}
		}
	}
	
	public func isValiedAuthNumber() {
		if currentViewState.value.state == .auth {
			if authRelay.value.count == 6 {
				fetchEmailCode(email: emailRelay.value, code: authRelay.value)
			} else {
				currentViewState.accept(.init(state: .auth, enabled: false))
			}
		}
	}
	
	public func fetchEmailAuth(email: String) {
		signUpUseCase.fetchEmailAuth(email: email)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				print(response.body)
				if response.success {
					currentViewState.accept(.init(state: .auth))
				}
				
			}).disposed(by: disposeBag)
	}
}

private extension EmailSignupIDViewModel {
	func fetchEmailConfirm(email: String) {
		signUpUseCase.fetchEmailConfirm(email: email)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				currentViewState.accept(.init(state: .email, enabled: response.success))
				
			}).disposed(by: disposeBag)
	}
	
	func fetchEmailCode(email: String, code: String) {
		signUpUseCase.fetchEmailCode(email: email, code: code)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				currentViewState.accept(.init(state: .auth, enabled: response.success))
				
			}).disposed(by: disposeBag)
	}
}
