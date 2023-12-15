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

// MARK: - VIEWMODEL INTERFACE
public protocol EmailSignupPhoneViewModelInterface {
	var phoneNumberRelay: BehaviorRelay<String> { get }
	var isSignupCompletionRelay: BehaviorRelay<Bool?> { get }
	var userData: UserData { get set }
	
	func fetchEmailSignup(userData: UserData)
}

public final class EmailSignupPhoneViewModel: EmailSignupPhoneViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var phoneNumberRelay: BehaviorRelay<String> = .init(value: "")
	public var isSignupCompletionRelay: BehaviorRelay<Bool?> = .init(value: nil)
	public var userData: UserData

	// MARK: - PRIVATE PROPERTY
	private let signupUseCase: EmailSignupUseCase
	private let disposeBag: DisposeBag

	// MARK: - INITIALIZE
	public init(userData: UserData, signupUseCase: EmailSignupUseCase) {
		self.signupUseCase = signupUseCase
		self.userData = userData
		self.disposeBag = .init()
	}
	
	// MARK: - PUBLIC METHOD
	public func fetchEmailSignup(userData: UserData) {
		signupUseCase.fetchEmailSignup(
			email: userData.email ?? "", 
			password: userData.password ?? "",
			userName: userData.userName ?? "", 
			userNickName: userData.userNickname ?? "",
			birth: userData.birth ?? "", 
			profileImg: userData.profileImg ?? Data(),
			phoneNum: userData.phoneNum ?? ""
		)
		.subscribe(onSuccess: { [weak self] response in
			guard let self else { return }

			self.isSignupCompletionRelay.accept(response.success)
		}).disposed(by: disposeBag)
	}
}
