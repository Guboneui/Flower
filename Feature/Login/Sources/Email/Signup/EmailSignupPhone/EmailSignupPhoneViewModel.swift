//
//  EmailSignupPhoneViewModel.swift
//  Login
//
//  Created by 김동겸 on 12/7/23.
//

import Foundation

import RxRelay

public final class EmailSignupPhoneViewModel {
	var phoneNumberRelay: BehaviorRelay<String> = .init(value: "")

}
