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

public final class EmailSignupIDViewModel {
	var emailRelay: BehaviorRelay<String> = .init(value: "")
	var authRelay: BehaviorRelay<String> = .init(value: "")
	var emailRegexBool: PublishSubject<Bool> = .init()
	
	let message: PublishSubject<AuthSendResponse> = .init()
	let confirmMessage: PublishSubject<EmailConfirmResponse> = .init()
	
	private let signUpUseCase: EmailSignupIDUseCaseInterface
	
	let disposeBag: DisposeBag
	
	let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
	
	public init(usecase: EmailSignupIDUseCaseInterface) {
		self.signUpUseCase = usecase
		self.disposeBag = .init()
	}
	
	func isValid(email: String) {
		if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
					fetchEmailConfirm(with: email)
				}
		emailRegexBool.onNext(false)
	}
	
	func fetchEmailConfirm(with email: String) {
		print("이메일 중복확인")
		signUpUseCase.fetchEmailConfirm(email: email)
			.subscribe(onSuccess: { [weak self] respose in
				guard let self else { return }
				self.emailRegexBool.onNext(respose.success)
			})
			.disposed(by: disposeBag)
	}
	
	func fetchEmailAuthCode(with email: String) {
		print("usecase로 해당 이메일을 보낸다: \(email)")
		signUpUseCase.fetchAuthEmail(email: email)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }

				self.message.onNext(response)
			})
			.disposed(by: disposeBag)
	}
}
