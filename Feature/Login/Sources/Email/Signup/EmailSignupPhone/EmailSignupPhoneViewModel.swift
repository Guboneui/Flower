//
//  EmailSignupPhoneViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/7/23.
//

import Foundation

import LoginDomain

import RxRelay
import RxSwift

public final class EmailSignupPhoneViewModel {
	public var userData: UserData
	public var phoneNumberRelay: BehaviorRelay<String> = .init(value: "")
	public var isSignupCompletionRelay: BehaviorRelay<Bool?> = .init(value: nil)

	private let signupUseCase: EmailSignupUseCase
	private let disposeBag: DisposeBag

	public init(userData: UserData, signupUseCase: EmailSignupUseCase) {
		self.signupUseCase = signupUseCase
		self.userData = userData
		self.disposeBag = .init()
	}
	
	public func fetchEmailSignup(userData: UserData) {
		signupUseCase.fetchEmailSignup(
			email: userData.email ?? "", 
			password: userData.password ?? "",
			userName: userData.userName ?? "", 
			userNickName: userData.userNickname ?? "",
			birth: userData.birth ?? "", 
			profileImg: userData.profileImg ?? Data(),
			phoneNum: userData.phoneNum ?? "")
		.subscribe(onSuccess: { [weak self] response in
			guard let self else { return }

			self.isSignupCompletionRelay.accept(response.success)
		}).disposed(by: disposeBag)
	}
	
}
