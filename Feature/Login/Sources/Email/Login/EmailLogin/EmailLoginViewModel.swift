//
//  EmailLoginViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/19/23.
//

import Foundation

import LoginDomain
import LoginEntity

import RxRelay
import RxSwift

// MARK: - VIEWMODEL INTERFACE
public protocol EmailLoginViewModelInterface {
	var emailRelay: BehaviorRelay<String> { get }
	var passwordRelay: BehaviorRelay<String> { get }
	var isEmailEntered: BehaviorRelay<Bool> { get }
	var isPasswordEntered: BehaviorRelay<Bool> { get }
	var isSuccessLogin: BehaviorRelay<Bool?> { get }
	
	func fetchEmailLogin()
}

public final class EmailLoginViewModel: EmailLoginViewModelInterface {
	
	// MARK: - PUBLIC PROPERTY
	public var emailRelay: BehaviorRelay<String> = .init(value: "")
	public var passwordRelay: BehaviorRelay<String> = .init(value: "")
	public var isEmailEntered: BehaviorRelay<Bool> = .init(value: false)
	public var isPasswordEntered: BehaviorRelay<Bool> = .init(value: false)
	public var isSuccessLogin: BehaviorRelay<Bool?> = .init(value: nil)

	// MARK: - PRIVATE PROPERTY
	private let loginUseCase: UsersUseCaseInterface
	private var disposeBag: DisposeBag

	// MARK: - INITIALIZE
	public init(useCase: UsersUseCaseInterface) {
		self.loginUseCase = useCase
		self.disposeBag = .init()
	}
	
	// MARK: - PUBLIC METHOD
	public func fetchEmailLogin() {
		loginUseCase.fetchEmailLogin(
			email: emailRelay.value,
			password: passwordRelay.value
		)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				self.isSuccessLogin.accept(response.success)
			}).disposed(by: disposeBag)
	}
}
