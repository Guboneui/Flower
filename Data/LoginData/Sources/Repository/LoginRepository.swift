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
	
	public func fetchEmailAuthAPI(email: String) -> Single<EmailAuthResponse> {
		request(endPoint: .emailAuth(email: email))
	}
	
	public func fetchEmailCodeAPI(email: String, code: String) -> Single<EmailCodeResponse> {
		request(endPoint: .emailCode(email: email, code: code))
	}
	
	public func fetchEmailSignupAPI(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse> {
		request(
			endPoint: .emailSignup(
				email: userSignupDTO.email,
				password: userSignupDTO.password,
				userName: userSignupDTO.userName,
				userNickName: userSignupDTO.userNickName,
				birth: userSignupDTO.birth,
				profileImg: userSignupDTO.profileImg,
				phoneNum: userSignupDTO.phoneNum
			)
		)
	}
	
	public init() {
		super.init(networkProvider: NetworkProvider())
	}
}

