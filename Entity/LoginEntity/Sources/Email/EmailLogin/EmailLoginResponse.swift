//
//  EmailLoginResponse.swift
//  LoginEntity
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

public struct EmailLoginResponse: Codable {
	public let message: String
	public let body: LoginBody?
	public let success: Bool
}

public struct LoginBody: Codable {
	public let email: String
	public let token: String
}
