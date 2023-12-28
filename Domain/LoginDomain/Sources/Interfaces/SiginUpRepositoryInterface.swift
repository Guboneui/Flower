//
//  SiginUpRepositoryInterface.swift
//  LoginDomain
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

import LoginEntity

import RxSwift

public protocol SiginUpRepositoryInterface {
	func fetchEmailConfirm(params: EmailConfirmRequestDTO) -> Single<EmailConfirmResponseDTO>
	func fetchSendAuthCode(params: SendAuthCodeRequestDTO) -> Single<SendAuthCodeResponseDTO>
	func fetchAuthCodeConfirm(params: AuthCodeConfirmRequestDTO) -> Single<AuthCodeConfirmResponseDTO>
}
