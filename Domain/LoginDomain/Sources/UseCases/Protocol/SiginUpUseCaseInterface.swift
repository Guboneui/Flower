//
//  SiginUpUseCaseInterface.swift
//  LoginDomain
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

import LoginEntity

import RxSwift

public protocol SiginUpUseCaseInterface {
	func EmailConfirmUseCaseMethod(params: EmailConfirmRequestDTO) -> Single<EmailConfirmResponseDTO>
	func SendAuthCodeUseCaseMethod(params: SendAuthCodeRequestDTO) -> Single<SendAuthCodeResponseDTO>
	func AuthCodeConfirmUseCaseMethod(params: AuthCodeConfirmRequestDTO) -> Single<AuthCodeConfirmResponseDTO>
}
