//
//  SendAuthCodeResponseDTO.swift
//  LoginEntity
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

public struct SendAuthCodeResponseDTO: Codable {
	public let message: String?
	public let body: String?
	public let success: Bool?
	public let timestamp: String?
	public let error: String?
	public let status: Bool?
	public let path: String?
	
	public init(
		message: String?,
		body: String?,
		success: Bool?,
		timestamp: String?,
		error: String?,
		status: Bool?,
		path: String?
	) {
		self.message = message
		self.body = body
		self.success = success
		self.timestamp = timestamp
		self.error = error
		self.status = status
		self.path = path
	}
}
