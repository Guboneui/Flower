//
//  EmailLoginViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/19/23.
//

import Foundation
import OSLog

import LoginDomain
import LoginEntity
import NetworkHelper
import SecureStorageKit

import RxRelay
import RxSwift

// MARK: - VIEWMODEL INTERFACE
public protocol EmailLoginViewModelInterface {
	var emailRelay: BehaviorRelay<String> { get }
	var passwordRelay: BehaviorRelay<String> { get }
	var isEmailEntered: BehaviorRelay<Bool> { get }
	var isPasswordEntered: BehaviorRelay<Bool> { get }
	var isLoginCompleted: BehaviorRelay<Bool?> { get }
	
	func fetchEmailLogin()
}

public final class EmailLoginViewModel: EmailLoginViewModelInterface {
	
	// MARK: - PUBLIC PROPERTY
	public var emailRelay: BehaviorRelay<String> = .init(value: "")
	public var passwordRelay: BehaviorRelay<String> = .init(value: "")
	public var isEmailEntered: BehaviorRelay<Bool> = .init(value: false)
	public var isPasswordEntered: BehaviorRelay<Bool> = .init(value: false)
	public var isLoginCompleted: BehaviorRelay<Bool?> = .init(value: nil)
	
	// MARK: - PRIVATE PROPERTY
	private let loginUseCase: LoginUseCaseInterface
	private var disposeBag: DisposeBag
	
	// MARK: - INITIALIZE
	public init(useCase: LoginUseCaseInterface) {
		self.loginUseCase = useCase
		self.disposeBag = .init()
	}
	
	// MARK: - PUBLIC METHOD
	public func fetchEmailLogin() {
		loginUseCase.fetchEmailLogin(
			email: emailRelay.value,
			password: passwordRelay.value
		).subscribe(onSuccess: { [weak self] responseData in
			guard let self else { return }
			
			KeyChainManager.create(key: .accessToken, value: responseData.accessToken)
			self.isLoginCompleted.accept(true)
		}, onFailure: { [weak self] error in
			guard let self else { return }
			guard let error = error as? NetworkErrorModel else {				
				os_log(.error, log: .APIError, "%@", "[EmailLogin] \(error.localizedDescription)")
				self.isLoginCompleted.accept(false)
				return
			}
			
			os_log(.error, log: .APIError, "%@", "[EmailLogin] \(error.message)")
			self.isLoginCompleted.accept(false)
		}).disposed(by: disposeBag)
	}
}
