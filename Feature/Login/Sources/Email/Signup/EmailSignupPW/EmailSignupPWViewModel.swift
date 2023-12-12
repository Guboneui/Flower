//
//  EmailSignupPWViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/6/23.
//

import Foundation

import RxRelay

public final class EmailSignupPWViewModel {
	var pwRelay: BehaviorRelay<String> = .init(value: "")
	var pwCheckRelay: BehaviorRelay<String> = .init(value: "")
	
	var pwBool: BehaviorRelay<Bool?> = .init(value: nil)
	var pwCheckBool: BehaviorRelay<Bool?> = .init(value: nil)
	
	let pwRegex: String = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
	
	func isValiedPW() {
		if NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: pwRelay.value) {
			pwBool.accept(true)
		} else {
			pwBool.accept(false)
		}
	}
	
	func isValiedPWCheck() {
		if pwCheckRelay.value == pwRelay.value {
			pwCheckBool.accept(true)
		} else {
			pwCheckBool.accept(false)
		}
	}
}
