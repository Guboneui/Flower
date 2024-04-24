//
//  LoginRepository.swift
//  LoginData
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

import LoginDomain
import LoginEntity
import LoginService
import NetworkHelper

import RxSwift

public final class LoginRepository: NetworkRepository<LoginAPI>, LoginRepositoryInterface {
	public func fetchEmailLoginAPI(email: String, password: String) -> Single<EmailLoginResponse> {
		request(endPoint: .emailLogin(email: email, password: password))
	}
	
	public func fetchEmailConfirmAPI(email: String) -> Single<EmailConfirmResponse> {
		request(endPoint: .emailConfirm(email: email))
	}
	
	public func fetchEmailCodeSentAPI(email: String) -> Single<EmailAuthResponse> {
		request(endPoint: .emailCodeSent(email: email))
	}
	
	public func fetchEmailCodeConfirmAPI(email: String, code: String) -> Single<EmailCodeResponse> {
		request(endPoint: .emailCodeConfirm(email: email, code: code))
	}
	
	public func fetchEmailSignupAPI(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse> {
		request(
			endPoint: .emailSignup(
				email: userSignupDTO.email,
				password: userSignupDTO.password,
				name: userSignupDTO.name,
				nickname: userSignupDTO.nickname,
				birth: userSignupDTO.birth,
				avatar: userSignupDTO.avatar,
				phoneNum: userSignupDTO.phoneNum
			)
		)
	}
	
	public init() {
		super.init(networkProvider: NetworkProvider())
	}
}

