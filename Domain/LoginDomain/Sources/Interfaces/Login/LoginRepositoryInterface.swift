//
//  LoginRepositoryInterface.swift
//  LoginDomain
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

import LoginEntity
import NetworkHelper

import RxSwift

public protocol LoginRepositoryInterface {
	func fetchEmailLoginAPI(email: String, password: String) -> Single<EmailLoginResponse>
	func fetchEmailConfirmAPI(email: String) -> Single<EmptyResponse>
	func fetchEmailCodeSentAPI(email: String) -> Single<EmptyResponse>
	func fetchEmailCodeConfirmAPI(email: String, code: String) -> Single<EmptyResponse>
	func fetchEmailSignupAPI(userSignupDTO: UserSignupDTO) -> Single<EmptyResponse>
}
