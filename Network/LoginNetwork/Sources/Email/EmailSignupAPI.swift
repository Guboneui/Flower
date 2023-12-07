//
//  SignupAPI.swift
//  LoginNetwork
//
//  Created by 김동겸 on 11/24/23.
//

import Foundation

import Moya

public enum EmailSignupAPI {
	case emailAuth(email: String)
	case emailConfirm(email: String)
	case emailCode(email: String, code: String)
}

extension EmailSignupAPI: TargetType {
	public var baseURL: URL {
		guard let url = URL(string: "http://43.202.77.12:8080/api/users/mail") else {
			fatalError("Invalid base URL")
		}
		return url
	}
	
	public var path: String {
		switch self {
		case .emailAuth:
			return "/send"
			
		case .emailConfirm:
			return "/confirm"
			
		case .emailCode:
			return "/code"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .emailAuth:
			return .post
			
		case .emailConfirm:
			return .post
			
		case .emailCode:
			return .post
		}
	}
	
	public var task: Moya.Task {
		switch self {
		case .emailAuth(let email):
			return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
			
		case .emailConfirm(email: let email):
			return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
			
		case .emailCode(email: let email, code: let code):
			return .requestParameters(parameters: ["email": email, "code": code], encoding: JSONEncoding.default)
		}
	}
	
	public var headers: [String: String]? {
		nil
	}
}
