//
//  EmailLoginResponse.swift
//  LoginEntity
//
//  Created by 김동겸 on 12/19/23.
//

import Foundation

public struct EmailLoginResponse: Codable {
	public let message: String
	public let body: String
	public let success: Bool
}
