//
//  EmailSignupNameViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/7/23.
//

import Foundation

import LoginEntity

import RxRelay

// MARK: - VIEWMODEL INTERFACE
public protocol EmailSignupNameViewModelInterface {
	var nameRelay: BehaviorRelay<String> { get }
	var userSignupDTO: UserSignupDTO { get set }
}

public final class EmailSignupNameViewModel: EmailSignupNameViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var userSignupDTO: UserSignupDTO
	public var nameRelay: BehaviorRelay<String> = .init(value: "")
	
	// MARK: - INITIALIZE
	init(userSignupDTO: UserSignupDTO) {
		self.userSignupDTO = userSignupDTO
	}
}
