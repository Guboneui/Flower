//
//  EmailLoginUseCaseInterface.swift
//  LoginDomain
//
//  Created by 김동겸 on 12/19/23.
//

import Foundation

import LoginEntity

import RxSwift

public protocol EmailLoginUseCaseInterface {
	func fetchEmailLogin(email: String, password: String) -> Single<EmailLoginResponse>
}
