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
	
	let message: PublishSubject<AuthSendResponse> = .init()
	
	private let signUpUseCase: EmailSignupIDUseCaseInterface
	
	let disposeBag: DisposeBag
	
	public init(usecase: EmailSignupIDUseCaseInterface) {
		self.signUpUseCase = usecase
		self.disposeBag = .init()
	}
	
	func isValid() -> Bool {
		return emailRelay.value.contains("@") && emailRelay.value.contains(".")
	}
	
	func fetchEmailAuthCode(with email: String) {
		print("usecase로 해당 이메일을 보낸다: \(email)")
		signUpUseCase.fetchMessage(email: email)
			.subscribe(onSuccess: { ttt in
				self.message.onNext(ttt)
			})
			.disposed(by: disposeBag)
	}
}
