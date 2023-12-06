//
//  AuthSendRepository.swift
//  LoginData
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

import LoginDomain
import LoginEntity
import LoginNetwork
import NetworkHelper

import RxSwift

public final class EmailSignupIDRepository: NetworkRepository<EmailSignupAPI>, EmailSignupIDRepositoryInterface {
	public func fetchEmailConfirmAPI(email: String) -> Single<EmailConfirmResponse> {
		request(endPoint: .MailConfirm(email: email))
	}
	
	public func fetchEmailAuthAPI(email: String) -> Single<EmailAuthResponse> {
		request(endPoint: .MailAuth(email: email))
	}
	
	public func fetchEmailCodeAPI(email: String, code: String) -> Single<EmailCodeResponse> {
		request(endPoint: .MailCode(email: email, code: code))
	}
	
	public init() {
		super.init(networkProvider: NetworkProvider())
	}
}
