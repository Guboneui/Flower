//
//  EmailCodeResponse.swift
//  LoginEntity
//
//  Created by 김동겸 on 12/4/23.
//

import Foundation

public struct EmailCodeResponse: Codable {
	public let message: String
	public let body: String
	public let success: Bool
}
