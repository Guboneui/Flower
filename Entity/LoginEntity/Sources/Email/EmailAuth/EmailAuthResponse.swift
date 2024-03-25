//
//  EmailAuthResponse.swift
//  LoginEntity
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

public struct EmailAuthResponse: Codable {
	public let message: String
	public let body: String
	public let success: Bool
}
