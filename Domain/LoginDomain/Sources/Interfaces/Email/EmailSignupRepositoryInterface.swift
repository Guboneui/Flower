//
//  AuthSendRepositoryInterface.swift
//  LoginDomain
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginEntity

import RxSwift

public protocol EmailSignupRepositoryInterface {
	func fetchEmailConfirmAPI(email: String) -> Single<EmailConfirmResponse>
	func fetchEmailAuthAPI(email: String) -> Single<EmailAuthResponse>
	func fetchEmailCodeAPI(email: String, code: String) -> Single<EmailCodeResponse>
	func fetchEmailSignupAPI(
		email: String, 
		password: String,
		userName: String, 
		userNickName: String?,
		birth: String?, 
		profileImg: Data?,
		phoneNum: String) -> Single<EmailSignupResponse>
}
