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
	
	private let emailSignupRepository: EmailSignupRepositoryInterface
	
	public init(emailSignupRepository: EmailSignupRepositoryInterface) {
		self.emailSignupRepository = emailSignupRepository
	}
	
	public func fetchEmailConfirm(email: String) -> Single<EmailConfirmResponse> {
		return emailSignupRepository.fetchEmailConfirmAPI(email: email)
	}
	
	public func fetchEmailAuth(email: String) -> Single<EmailAuthResponse> {
		return emailSignupRepository.fetchEmailAuthAPI(email: email)
	}
	
	public func fetchEmailCode(email: String, code: String) -> Single<EmailCodeResponse> {
		return emailSignupRepository.fetchEmailCodeAPI(email: email, code: code)
	}
	
	public func fetchEmailSignup(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse> {
		return emailSignupRepository.fetchEmailSignupAPI(userSignupDTO: userSignupDTO)
	}
}
