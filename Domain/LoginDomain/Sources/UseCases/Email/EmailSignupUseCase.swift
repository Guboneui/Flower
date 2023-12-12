//
//  AuthSendUseCase.swift
//  LoginDomain
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginEntity

import RxSwift

public final class EmailSignupUseCase: EmailSignupUseCaseInterface {
	private let emailSignupIDRepository: EmailSignupRepositoryInterface
	
	public init(emailSignupIDRepository: EmailSignupRepositoryInterface) {
		self.emailSignupIDRepository = emailSignupIDRepository
	}
	
	public func fetchEmailConfirm(email: String) -> Single<EmailConfirmResponse> {
		return emailSignupIDRepository.fetchEmailConfirmAPI(email: email)
	}
	
	public func fetchEmailAuth(email: String) -> Single<EmailAuthResponse> {
		return emailSignupIDRepository.fetchEmailAuthAPI(email: email)
	}
	
	public func fetchEmailCode(email: String, code: String) -> Single<EmailCodeResponse> {
		return emailSignupIDRepository.fetchEmailCodeAPI(email: email, code: code)
	}
	
	public func fetchEmailSignup(
		email: String, password: String, userName: String,
		userNickName: String?, birth: String?,
		profileImg: Data?, phoneNum: String) -> RxSwift.Single<LoginEntity.EmailSignupResponse> {
		return emailSignupIDRepository.fetchEmailSignupAPI(
			email: email, password: password, userName: userName,
			userNickName: userNickName, birth: birth,
			profileImg: profileImg, phoneNum: phoneNum)
	}
}
