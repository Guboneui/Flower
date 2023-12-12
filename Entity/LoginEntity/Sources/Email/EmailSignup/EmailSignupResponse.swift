//
//  EmailSignupResponse.swift
//  LoginEntity
//
//  Created by 김동겸 on 12/10/23.
//

import Foundation

public struct EmailSignupResponse: Codable {
	public let message: String
	public let body: String
	public let success: Bool
}
