//
//  NetworkErrorModel.swift
//  NetworkHelper
//
//  Created by 구본의 on 4/23/24.
//

import Foundation

public struct NetworkErrorModel: Codable, Error {
	public let code: String
	public let title: String
	public let message: String
}
