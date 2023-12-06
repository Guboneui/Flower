//
//  AuthSendUseCase.swift
//  LoginDomain
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginEntity

import RxSwift

public final class EmailSignupIDUseCase: EmailSignupIDUseCaseInterface {
	private let emailSignupIDRepository: EmailSignupIDRepositoryInterface
	
	public init(emailSignupIDRepository: EmailSignupIDRepositoryInterface) {
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
}
