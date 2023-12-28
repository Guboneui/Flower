//
//  SiginUpRepository.swift
//  LoginData
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

import LoginDomain
import LoginEntity
import LoginNetwork
import NetworkHelper

import RxSwift

public final class SiginUpRepository: NetworkRepository<SiginUpAPI>, SiginUpRepositoryInterface {
	public init() {
		super.init(networkProvider: NetworkProvider())
	}
	
	public func fetchEmailConfirm(params: EmailConfirmRequestDTO) -> Single<EmailConfirmResponseDTO> {
		request(endPoint: .emailConfirm(parameters: params))
	}

	public func fetchSendAuthCode(params: SendAuthCodeRequestDTO) -> Single<SendAuthCodeResponseDTO> {
		request(endPoint: .sendAuthCode(parameters: params))
	}
	
	public func fetchAuthCodeConfirm(params: AuthCodeConfirmRequestDTO) -> Single<AuthCodeConfirmResponseDTO> {
		request(endPoint: .authCodeConfirm(parameters: params))
	}
	
	
	
}
