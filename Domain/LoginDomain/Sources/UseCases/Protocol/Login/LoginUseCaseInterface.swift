//
//  LoginUseCaseInterface.swift
//  LoginDomain
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

import LoginEntity
import NetworkHelper

import RxSwift

public protocol LoginUseCaseInterface {
	func fetchEmailLogin(email: String, password: String) -> Single<EmailLoginResponse>
	func fetchEmailConfirm(email: String) -> Single<EmailConfirmResponse>
	func fetchEmailCodeSent(email: String) -> Single<EmptyResponse>
	func fetchEmailCodeConfirm(email: String, code: String) -> Single<EmptyResponse>
	func fetchEmailSignup(userSignupDTO: UserSignupDTO) -> Single<EmailSignupResponse>
}
