//
//  GuestHouseAPIInfo.swift
//  LoginService
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

public enum GuestHouseAPIInfo {
	static let baseURLString: String = "http://52.78.141.54:80"
	
	static let authURLString: String = baseURLString + "/v1/auth"
	static let usersURLString: String = baseURLString + "/v1/users"
	
	static var authURL: URL {
		guard let url = URL(string: authURLString) else {
			fatalError("Invalid base URL")
		}
		return url
	}
	
	static var usersURL: URL {
		guard let url = URL(string: usersURLString) else {
			fatalError("Invalid base URL")
		}
		return url
	}
}
