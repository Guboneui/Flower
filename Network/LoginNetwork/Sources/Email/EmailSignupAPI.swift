//
//  SignupAPI.swift
//  LoginNetwork
//
//  Created by 김동겸 on 11/24/23.
//

import Foundation

import Moya

public enum EmailSignupAPI {
	case MailAuth(email: String)
	case MailConfirm(email: String)
	case MailCode(email: String, code: String)
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
		case .MailAuth:
			return "/send"
			
		case .MailConfirm:
			return "/confirm"
			
		case .MailCode:
			return "/code"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .MailAuth:
			return .post
			
		case .MailConfirm:
			return .post
			
		case .MailCode:
			return .post
		}
	}
	
	public var task: Moya.Task {
		switch self {
		case .MailAuth(let email):
			return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
			
		case .MailConfirm(email: let email):
			return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
			
		case .MailCode(email: let email, code: let code):
			return .requestParameters(parameters: ["email": email, "code": code], encoding: JSONEncoding.default)
		}
	}
	
	public var headers: [String: String]? {
		nil
	}
}
