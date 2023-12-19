//
//  EmailLoginUseCase.swift
//  LoginDomain
//
//  Created by 김동겸 on 12/19/23.
//

import Foundation

import LoginEntity

import RxSwift

public final class EmailLoginUseCase: EmailLoginUseCaseInterface {
	
	private let emailLoginRepository: EmailLoginRepositoryInterface
	
	public init(emailLoginRepository: EmailLoginRepositoryInterface) {
		self.emailLoginRepository = emailLoginRepository
	}
	
	public func fetchEmailLogin(email: String, password: String) -> Single<EmailLoginResponse> {
		return emailLoginRepository.fetchEmailLoginAPI(email: email, password: password)
	}
	
	
}
