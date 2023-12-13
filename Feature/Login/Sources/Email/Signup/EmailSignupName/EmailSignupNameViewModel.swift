//
//  EmailSignupNameViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/7/23.
//

import Foundation

import RxRelay

public final class EmailSignupNameViewModel {
	
	var userData: UserData
	var nameRelay: BehaviorRelay<String> = .init(value: "")

	init(userData: UserData) {
		self.userData = userData
	}
}
