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
	
	public func fetchEmailSignupAPI(
		email: String, password: String, userName: String,
		userNickName: String?, birth: String?,
		profileImg: Data?, phoneNum: String) -> RxSwift.Single<LoginEntity.EmailSignupResponse> {
		request(endPoint: .emailSignup(
			email: email, password: password, userName: userName,
			userNickName: userNickName, birth: birth,
			profileImg: profileImg, phoneNum: phoneNum))
	}
	
	public init() {
		super.init(networkProvider: NetworkProvider())
	}
}
