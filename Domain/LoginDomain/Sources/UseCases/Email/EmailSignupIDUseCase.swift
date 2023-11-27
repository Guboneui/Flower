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
	private let authSendRepository: EmailSignupIDRepositoryInterface
	
	public init(authSendRepository: EmailSignupIDRepositoryInterface) {
		self.authSendRepository = authSendRepository
	}
	
	public func fetchMessage(email: String) -> Single<AuthSendResponse> {
		return authSendRepository.fetchTest(email: email)
	}
}
