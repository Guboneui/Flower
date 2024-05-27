//
//  LoginUseCase.swift
//  LoginDomain
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

import LoginEntity
import NetworkHelper

import RxSwift

public final class LoginUseCase: LoginUseCaseInterface {
	
	private let loginRepository: LoginRepositoryInterface
	
	public init(loginRepository: LoginRepositoryInterface) {
		self.loginRepository = loginRepository
	}
	
	public func fetchEmailLogin(email: String, password: String) -> Single<EmailLoginResponse> {
		loginRepository.fetchEmailLoginAPI(email: email, password: password)
	}
	
	public func fetchEmailConfirm(email: String) -> Single<EmptyResponse> {
		loginRepository.fetchEmailConfirmAPI(email: email)
	}
	
	public func fetchEmailCodeSent(email: String) -> Single<EmptyResponse> {
		loginRepository.fetchEmailCodeSentAPI(email: email)
	}
	
	public func fetchEmailCodeConfirm(email: String, code: String) -> Single<EmptyResponse> {
		loginRepository.fetchEmailCodeConfirmAPI(email: email, code: code)
	}
	
	public func fetchEmailSignup(userSignupDTO: UserSignupDTO) -> Single<EmptyResponse> {
		loginRepository.fetchEmailSignupAPI(userSignupDTO: userSignupDTO)
	}
}
