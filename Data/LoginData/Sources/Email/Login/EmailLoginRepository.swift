//
//  EmailLoginRepository.swift
//  LoginData
//
//  Created by 김동겸 on 12/19/23.
//

import Foundation

import LoginDomain
import LoginEntity
import LoginNetwork
import NetworkHelper

import RxSwift

public final class EmailLoginRepository: NetworkRepository<UsersAPI>, EmailLoginRepositoryInterface {
	public func fetchEmailLoginAPI(email: String, password: String) -> Single<EmailLoginResponse> {
		request(endPoint: .emailLogin(email: email, password: password))
	}
}
