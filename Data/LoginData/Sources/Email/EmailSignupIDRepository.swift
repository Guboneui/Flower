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

public final class EmailSignupIDRepository: NetworkRepository<EmailSignupAPI>, EmailSignupIDRepositoryInterface{
	public func fetchTest(email: String) -> Single<AuthSendResponse> {
		request(endPoint: .AuthSend(email: email))
	}
	
	public init() {
		super.init(networkProvider: NetworkProvider())
	}
}
