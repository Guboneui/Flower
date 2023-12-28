//
//  EmailConfirmResponseDTO.swift
//  LoginEntity
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

public struct EmailConfirmResponseDTO: Codable {
	public let message: String
	public let body: String
	public let success: Bool
	
	public init(message: String, body: String, success: Bool) {
		self.message = message
		self.body = body
		self.success = success
	}
}
