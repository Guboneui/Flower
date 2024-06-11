//
//  EmailLoginResponse.swift
//  LoginEntity
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

public struct EmailLoginResponse: Codable {
	public let accessToken: String
	public let refreshToken: String
	public let provider: String
}
