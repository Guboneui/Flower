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
	
	public func fetchEmailAuth(email: String) -> Single<EmailAuthResponse> {
		return loginRepository.fetchEmailAuthAPI(email: email)
	}
	
	public func fetchEmailCode(email: String, code: String) -> Single<EmailCodeResponse> {
		return loginRepository.fetchEmailCodeAPI(email: email, code: code)
	}
	
	public func fetchEmailSignup(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse> {
		return loginRepository.fetchEmailSignupAPI(userSignupDTO: userSignupDTO)
	}
}
