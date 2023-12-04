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
	
	public func fetchAuthEmail(email: String) -> Single<AuthSendResponse> {
		return emailSignupIDRepository.fetchAuthEmailAPI(email: email)
	}
}
