//
//  EmailSiginUpEmailViewModel.swift
//  Login
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

import LoginDomain
import LoginEntity
import ResourceKit

import RxRelay
import RxSwift

public final class EmailSiginUpEmailViewModel {
	private let siginUpUseCase: SiginUpUseCaseInterface
	private let disposeBag: DisposeBag
	
	public struct EmailConfirmSet {
		public var emailConfirmSuccess: Bool = false
		public var emailConfirmLabel: String = ""
	}
	
	public struct AuthCodeConfirmSet {
		public var authCodeConfirmSuccess: Bool = false
		public var authCodeConfirmLabel: String = ""
	}
	
	public var emailConfirmResponse: PublishRelay = PublishRelay<EmailConfirmResponseDTO>()
	public var authCodeResponse: PublishRelay = PublishRelay<SendAuthCodeResponseDTO>()
	public var authCodeConfirmResponse: PublishRelay = PublishRelay<AuthCodeConfirmResponseDTO>()
	
	public var emailConfirmState: PublishRelay = PublishRelay<EmailConfirmSet>()
	public var authCodeConfirmState: PublishRelay = PublishRelay<AuthCodeConfirmSet>()
	
	//init
	public init(siginUpUseCase: SiginUpUseCaseInterface) {
		self.siginUpUseCase = siginUpUseCase
		self.disposeBag = .init()
	}
	
	// MARK: - 상태변경
	public func setEmailConfirm() {
		_ = emailConfirmResponse.subscribe(onNext: { [weak self] result in
			guard let self else { return }
			let email = String(result.body.split(separator: " ")[1])
			if email.isValidEmail() {
				self.emailConfirmState.accept(EmailConfirmSet(
					emailConfirmSuccess: result.success,
					emailConfirmLabel: result.message
				))
			} else {
				self.emailConfirmState.accept(EmailConfirmSet(
					emailConfirmSuccess: false,
					emailConfirmLabel: "잘못된 이메일 형식입니다"
				))
			}
			
		})
	}
	
	public func setAuthCode() {
		_ = authCodeConfirmResponse.subscribe(onNext: { [weak self] result in
			guard let self else { return }
			self.authCodeConfirmState.accept(AuthCodeConfirmSet(
				authCodeConfirmSuccess: result.success,
				authCodeConfirmLabel: result.message))
		})
	}
}

// MARK: - api 호출
extension EmailSiginUpEmailViewModel {
	public func emailConfirmMethod(params: EmailConfirmRequestDTO) {
		siginUpUseCase.EmailConfirmUseCaseMethod(params: params)
			.subscribe { [weak self] result in
				guard let self else { return }
				self.emailConfirmResponse.accept(result)
			}.disposed(by: disposeBag)
	}
	
	public func sendAuthCodeMethod(params: SendAuthCodeRequestDTO) {
		siginUpUseCase.SendAuthCodeUseCaseMethod(params: params)
			.subscribe { [weak self] result in
				guard let self else { return }
				self.authCodeResponse.accept(result)
			}.disposed(by: disposeBag)
	}
	
	public func authCodeConfirmMethod(params: AuthCodeConfirmRequestDTO) {
		siginUpUseCase.AuthCodeConfirmUseCaseMethod(params: params)
			.subscribe { [weak self] result in
				guard let self else { return }
				self.authCodeConfirmResponse.accept(result)
			}.disposed(by: disposeBag)
	}
}

extension String {
	public func isValidEmail() -> Bool {
		let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
	}
}
