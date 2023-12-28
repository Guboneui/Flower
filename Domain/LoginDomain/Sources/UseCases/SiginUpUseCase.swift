//
//  SiginUpUseCase.swift
//  LoginDomain
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

import LoginEntity

import RxSwift

public final class SiginUpUseCase: SiginUpUseCaseInterface {
	private let  siginUpRepository: SiginUpRepositoryInterface
	
	public init(siginUpRepository: SiginUpRepositoryInterface) {
		self.siginUpRepository = siginUpRepository
	}
	
	public func EmailConfirmUseCaseMethod(
		params: EmailConfirmRequestDTO) -> Single<EmailConfirmResponseDTO> {
		return siginUpRepository.fetchEmailConfirm(params: params)
	}
	
	public func SendAuthCodeUseCaseMethod(params: SendAuthCodeRequestDTO) -> Single<SendAuthCodeResponseDTO> {
		return siginUpRepository.fetchSendAuthCode(params: params)
	}
	
	public func AuthCodeConfirmUseCaseMethod(params: AuthCodeConfirmRequestDTO) -> Single<AuthCodeConfirmResponseDTO> {
		return siginUpRepository.fetchAuthCodeConfirm(params: params)
	}
}
