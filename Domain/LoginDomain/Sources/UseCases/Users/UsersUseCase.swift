//
//  AuthSendUseCase.swift
//  LoginDomain
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginEntity

import RxSwift

public final class UsersUseCase: UsersUseCaseInterface {
	
	private let usersRepository: UsersRepositoryInterface
	
	public init(usersRepository: UsersRepositoryInterface) {
		self.usersRepository = usersRepository
	}
	
	public func fetchEmailLogin(email: String, password: String) -> Single<EmailLoginResponse> {
		return usersRepository.fetchEmailLoginAPI(email: email, password: password)
	}
	
	public func fetchEmailConfirm(email: String) -> Single<EmailConfirmResponse> {
		return usersRepository.fetchEmailConfirmAPI(email: email)
	}
	
	public func fetchEmailAuth(email: String) -> Single<EmailAuthResponse> {
		return usersRepository.fetchEmailAuthAPI(email: email)
	}
	
	public func fetchEmailCode(email: String, code: String) -> Single<EmailCodeResponse> {
		return usersRepository.fetchEmailCodeAPI(email: email, code: code)
	}
	
	public func fetchEmailSignup(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse> {
		return usersRepository.fetchEmailSignupAPI(userSignupDTO: userSignupDTO)
	}
}
