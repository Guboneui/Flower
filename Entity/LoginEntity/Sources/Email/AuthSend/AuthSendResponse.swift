//
//  SignupDTO.swift
//  LoginEntity
//
//  Created by 김동겸 on 11/26/23.
//

import Foundation

public struct AuthSendResponse: Codable {
	public let message: String
	public let body: String
	public let success: Bool
}
