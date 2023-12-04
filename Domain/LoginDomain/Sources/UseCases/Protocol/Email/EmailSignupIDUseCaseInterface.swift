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
	func fetchAuthEmail(email: String) -> Single<AuthSendResponse>
}
