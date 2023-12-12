//
//  AuthSendUseCaseInterface.swift
//  LoginDomain
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginEntity

import RxSwift

public protocol EmailSignupIDUseCaseInterface {
	func fetchEmailConfirm(email: String) -> Single<EmailConfirmResponse>
	func fetchEmailAuth(email: String) -> Single<EmailAuthResponse>
	func fetchEmailCode(email: String, code: String) -> Single<EmailCodeResponse>
}
