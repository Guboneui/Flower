//
//  EmailSignupResponse.swift
//  LoginEntity
//
//  Created by 김동겸 on 12/10/23.
//

import Foundation

public struct EmailSignupResponse: Codable {
	public let message: String
	public let body: SignupBody
	public let success: Bool
}

public struct SignupBody: Codable {
	public let email: String
	public let password: String
	public let imageUrl: String
}
