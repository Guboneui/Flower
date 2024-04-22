//
//  NetworkErrorModel.swift
//  NetworkHelper
//
//  Created by 구본의 on 4/23/24.
//

import Foundation

public struct NetworkErrorModel: Codable, Error {
	let code: String
	let title: String
	let message: String
}
