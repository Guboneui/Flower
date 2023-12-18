//
//  AuthSendRepository.swift
//  LoginData
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginDomain
import LoginEntity
import LoginNetwork
import NetworkHelper

import RxSwift

public final class EmailSignupRepository: NetworkRepository<EmailSignupAPI>, EmailSignupRepositoryInterface {
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
