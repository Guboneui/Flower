//
//  LoginRepositoryInterface.swift
//  LoginDomain
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

import LoginEntity

import RxSwift

public protocol LoginRepositoryInterface {
	func fetchEmailLoginAPI(email: String, password: String) -> Single<EmailLoginResponse>
	func fetchEmailConfirmAPI(email: String) -> Single<EmailConfirmResponse>
	func fetchEmailCodeSentAPI(email: String) -> Single<EmailAuthResponse>
	func fetchEmailCodeConfirmAPI(email: String, code: String) -> Single<EmailCodeResponse>
	func fetchEmailSignupAPI(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse>
}
