//
//  EmailConfirmResponse.swift
//  LoginEntity
//
//  Created by 김동겸 on 11/27/23.
//

import Foundation

public struct EmailConfirmResponse: Codable {
	public let message: String
	public let body: String
	public let success: Bool
}
