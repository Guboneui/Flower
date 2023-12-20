//
//  EmailSignupPhoneViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/7/23.
//

import Foundation

import LoginDomain
import LoginEntity

import RxRelay
import RxSwift

// MARK: - VIEWMODEL INTERFACE
public protocol EmailSignupPhoneViewModelInterface {
	var phoneNumberRelay: BehaviorRelay<String> { get }
	var isSignupCompletionRelay: BehaviorRelay<Bool?> { get }
	var userSignupDTO: UserSignupDTO { get set }
	
	func fetchEmailSignup(userSignupDTO: UserSignupDTO)
}

public final class EmailSignupPhoneViewModel: EmailSignupPhoneViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var phoneNumberRelay: BehaviorRelay<String> = .init(value: "")
	public var isSignupCompletionRelay: BehaviorRelay<Bool?> = .init(value: nil)
	public var userSignupDTO: UserSignupDTO

	// MARK: - PRIVATE PROPERTY
	private let useCase: UsersUseCaseInterface
	private let disposeBag: DisposeBag

	// MARK: - INITIALIZE
	public init(userSignupDTO: UserSignupDTO, useCase: UsersUseCaseInterface) {
		self.useCase = useCase
		self.userSignupDTO = userSignupDTO
		self.disposeBag = .init()
	}
	
	// MARK: - PUBLIC METHOD
	public func fetchEmailSignup(userSignupDTO: UserSignupDTO) {

		useCase.fetchEmailSignup(userSignupDTO: userSignupDTO)
		.subscribe(onSuccess: { [weak self] response in
			guard let self else { return }

			self.isSignupCompletionRelay.accept(response.success)
		}).disposed(by: disposeBag)
	}
}
