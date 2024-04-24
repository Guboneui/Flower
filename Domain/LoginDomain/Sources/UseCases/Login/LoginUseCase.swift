//
//  LoginUseCase.swift
//  LoginDomain
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

import LoginEntity

import RxSwift

public final class LoginUseCase: LoginUseCaseInterface {
	
	private let loginRepository: LoginRepositoryInterface
	
	public init(loginRepository: LoginRepositoryInterface) {
		self.loginRepository = loginRepository
	}
	
	public func fetchEmailLogin(email: String, password: String) -> Single<EmailLoginResponse> {
		return loginRepository.fetchEmailLoginAPI(email: email, password: password)
	}
	
	public func fetchEmailConfirm(email: String) -> Single<EmailConfirmResponse> {
		return loginRepository.fetchEmailConfirmAPI(email: email)
	}
	
	public func fetchEmailCodeSent(email: String) -> Single<EmailAuthResponse> {
		return loginRepository.fetchEmailCodeSentAPI(email: email)
	}
	
	public func fetchEmailCodeConfirm(email: String, code: String) -> Single<EmailCodeResponse> {
		return loginRepository.fetchEmailCodeConfirmAPI(email: email, code: code)
	}
	
	public func fetchEmailSignup(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse> {
		return loginRepository.fetchEmailSignupAPI(userSignupDTO: userSignupDTO)
	}
}
