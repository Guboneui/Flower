//
//  EmailSignupNameViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/7/23.
//

import UIKit

import LoginEntity

import RxRelay

// MARK: - VIEWMODEL INTERFACE
public protocol EmailSignupNameViewModelInterface {
	var nameRelay: BehaviorRelay<String> { get }
	var userProfileImage: BehaviorRelay<UIImage?> { get }
	var userSignupDTO: UserSignupDTO { get set }
}

public final class EmailSignupNameViewModel: EmailSignupNameViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var userSignupDTO: UserSignupDTO
	public var nameRelay: BehaviorRelay<String> = .init(value: "")
	public var userProfileImage: BehaviorRelay<UIImage?> = .init(value: nil)
	
	// MARK: - INITIALIZE
	public init(userSignupDTO: UserSignupDTO) {
		self.userSignupDTO = userSignupDTO
	}
}
