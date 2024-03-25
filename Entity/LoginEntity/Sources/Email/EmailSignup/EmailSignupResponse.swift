//
//  EmailSignupResponse.swift
//  LoginEntity
//
//  Created by 구본의 on 3/26/24.
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
	public let imageURL: String
	
	enum CodingKeys: String, CodingKey {
		case email = "email"
		case password = "password"
		case imageURL = "imageUrl"
	}
}
