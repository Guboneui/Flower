//
//  AuthCodeConfirmRequestDTO.swift
//  LoginEntity
//
//  Created by 김민희 on 2023/12/04.
//

import Foundation

public struct AuthCodeConfirmRequestDTO: Codable {
	public let email: String
	public let code: String
	
	public init(email: String, code: String) {
		self.email = email
		self.code = code
	}
}
