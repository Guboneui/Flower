//
//  EmailSignupPhoneViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/7/23.
//

import Foundation
import OSLog

import LoginDomain
import LoginEntity
import NetworkHelper

import RxRelay
import RxSwift

// MARK: - VIEWMODEL INTERFACE
public protocol EmailSignupPhoneViewModelInterface {
	var phoneNumberRelay: BehaviorRelay<String> { get }
	var isSignupCompletedRelay: BehaviorRelay<Bool?> { get }
	var userSignupDTO: UserSignupDTO { get set }
	
	func fetchEmailSignup()
}

public final class EmailSignupPhoneViewModel: EmailSignupPhoneViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var phoneNumberRelay: BehaviorRelay<String> = .init(value: "")
	public var isSignupCompletedRelay: BehaviorRelay<Bool?> = .init(value: nil)
	public var userSignupDTO: UserSignupDTO

	// MARK: - PRIVATE PROPERTY
	private let useCase: LoginUseCaseInterface
	private let disposeBag: DisposeBag

	// MARK: - INITIALIZE
	public init(userSignupDTO: UserSignupDTO, useCase: LoginUseCaseInterface) {
		self.useCase = useCase
		self.userSignupDTO = userSignupDTO
		self.disposeBag = .init()
	}
	
	// MARK: - PUBLIC METHOD
	public func fetchEmailSignup() {
		useCase.fetchEmailSignup(userSignupDTO: userSignupDTO)
		.subscribe(onSuccess: { [weak self] _ in
			guard let self else { return }

			self.isSignupCompletedRelay.accept(true)
		}, onFailure: { error in
			guard let error = error as? NetworkErrorModel else {
				os_log(.error, log: .APIError, "%@", "[EmailSignup] \(error.localizedDescription)")
				self.isSignupCompletedRelay.accept(false)
				return
			}
			
			os_log(.error, log: .APIError, "%@", "[EmailSignup] \(error.message)")
			self.isSignupCompletedRelay.accept(false)
		}).disposed(by: disposeBag)
	}
}
