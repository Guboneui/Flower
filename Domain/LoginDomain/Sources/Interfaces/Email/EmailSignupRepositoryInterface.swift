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
	func fetchEmailSignupAPI(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse>
}
