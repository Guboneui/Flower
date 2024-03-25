//
//  GuestHouseAPIInfo.swift
//  LoginService
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

public enum GuestHouseAPIInfo {
	static let baseURLString: String = "http://43.202.77.12:8080/api"
	
	static let usersURLString: String = baseURLString + "/users"
	static var usersURL: URL {
		guard let url = URL(string: usersURLString) else {
			fatalError("Invalid base URL")
		}
		return url
	}
}
