//
//  SendAuthCodeRequestDTO.swift
//  LoginEntity
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

public struct SendAuthCodeRequestDTO: Codable {
	public let email: String
	
	public init(email: String) {
		self.email = email
	}
}
