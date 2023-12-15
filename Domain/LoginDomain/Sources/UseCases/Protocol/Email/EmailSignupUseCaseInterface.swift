//
//  AuthSendUseCaseInterface.swift
//  LoginDomain
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginEntity

import RxSwift

public protocol EmailSignupUseCaseInterface {
	func fetchEmailConfirm(email: String) -> Single<EmailConfirmResponse>
	func fetchEmailAuth(email: String) -> Single<EmailAuthResponse>
	func fetchEmailCode(email: String, code: String) -> Single<EmailCodeResponse>
	func fetchEmailSignup(
		email: String, 
		password: String,
		userName: String, 
		userNickName: String?,
		birth: String?, 
		profileImg: Data?,
		phoneNum: String
	) -> Single<EmailSignupResponse>
}
