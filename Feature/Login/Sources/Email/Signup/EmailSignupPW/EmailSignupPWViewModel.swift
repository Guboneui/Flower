//
//  EmailSignupPWViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/6/23.
//

import Foundation

import RxRelay

// MARK: - VIEWMODEL INTERFACE
public protocol EmailSignupPWViewModelInterface {
	var pwRelay: BehaviorRelay<String> { get }
	var pwCheckRelay: BehaviorRelay<String> { get }
	var pwBool: BehaviorRelay<Bool?> { get }
	var pwCheckBool: BehaviorRelay<Bool?> { get }
	var userData: UserData { get set }
	
	func isValiedPW()
	func isValiedPWCheck()
}

public final class EmailSignupPWViewModel: EmailSignupPWViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var pwRelay: BehaviorRelay<String> = .init(value: "")
	public var pwCheckRelay: BehaviorRelay<String> = .init(value: "")
	public var pwBool: BehaviorRelay<Bool?> = .init(value: nil)
	public var pwCheckBool: BehaviorRelay<Bool?> = .init(value: nil)
	public var userData: UserData

	// MARK: - PRIVATE PROPERTY
	let pwRegex: String = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
	
	// MARK: - INITIALIZE
	init(userData: UserData) {
		self.userData = userData
	}
	
	// MARK: - PUBLIC METHOD
	public func isValiedPW() {
		if NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: pwRelay.value) {
			pwBool.accept(true)
		} else {
			pwBool.accept(false)
		}
	}
	
	public func isValiedPWCheck() {
		if pwCheckRelay.value == pwRelay.value {
			pwCheckBool.accept(true)
		} else {
			pwCheckBool.accept(false)
		}
	}
}
