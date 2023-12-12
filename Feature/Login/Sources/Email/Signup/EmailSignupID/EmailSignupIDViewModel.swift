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

enum PageState {
	case Email
	case Auth
}

struct PageSet {
	var state: PageState
	var enabled: Bool?
}

public final class EmailSignupIDViewModel {
	var emailRelay: BehaviorRelay<String> = .init(value: "")
	var authRelay: BehaviorRelay<String> = .init(value: "")
	
	var pageState: BehaviorRelay<PageSet> = .init(value: PageSet(state: .Email))
	
	let emailAuthAPIResponse: PublishSubject<EmailAuthResponse> = .init()
	let emailConfirmAPIResponse: PublishSubject<EmailConfirmResponse> = .init()
	let emailCodeAPIResponse: PublishSubject<EmailCodeResponse> = .init()
	
	private let signUpUseCase: EmailSignupIDUseCaseInterface
	
	let disposeBag: DisposeBag
	
	let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
	
	public init(usecase: EmailSignupIDUseCaseInterface) {
		self.signUpUseCase = usecase
		self.disposeBag = .init()
	}
	
	func isValidEmail() {
		if pageState.value.state == .Email {
			if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailRelay.value) {
				fetchEmailConfirm(email: emailRelay.value)
			} else {
				pageState.accept(.init(state: .Email, enabled: false))
			}
		}
	}
	
	func isValiedAuthNumber() {
		if pageState.value.state == .Auth {
			if authRelay.value.count == 6 {
				fetchEmailCode(email: emailRelay.value, code: authRelay.value)
			} else {
				pageState.accept(.init(state: .Auth, enabled: false))
			}
		}
	}
	
	func fetchEmailConfirm(email: String) {
		print("이메일 중복확인")
		signUpUseCase.fetchEmailConfirm(email: email)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				self.emailConfirmAPIResponse.onNext(response)
				pageState.accept(.init(state: .Email, enabled: response.success))
				
			}).disposed(by: disposeBag)
	}
	
	func fetchEmailAuth(email: String) {
		print("usecase로 해당 이메일을 보낸다: \(email)")
		signUpUseCase.fetchEmailAuth(email: email)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				self.emailAuthAPIResponse.onNext(response)
				
				if response.success == true {
					pageState.accept(.init(state: .Auth))
				}
				
			}).disposed(by: disposeBag)
	}
	
	func fetchEmailCode(email: String, code: String) {
		print("이메일 코드 검증")
		signUpUseCase.fetchEmailCode(email: email, code: code)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				self.emailCodeAPIResponse.onNext(response)
				pageState.accept(.init(state: .Auth, enabled: response.success))
				
			}).disposed(by: disposeBag)
	}
}
