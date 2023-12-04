//
//  AuthSendRepositoryInterface.swift
//  LoginDomain
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginEntity

import RxSwift

public protocol EmailSignupIDRepositoryInterface {
	func fetchEmailConfirmAPI(email: String) -> Single<EmailConfirmResponse>
	func fetchAuthEmailAPI(email: String) -> Single<AuthSendResponse>
}
