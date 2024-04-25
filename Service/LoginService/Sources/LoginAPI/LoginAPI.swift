//
//  UserAPI.swift
//  LoginService
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

import Moya

public enum LoginAPI {
	case emailLogin(email: String, password: String)
	case emailCodeSent(email: String)
	case emailConfirm(email: String)
	case emailCodeConfirm(email: String, code: String)
	case emailSignup(
		email: String?,
		password: String?,
		name: String?,
		nickname: String?,
		birth: String?,
		avatar: Data?,
		phoneNum: String?
	)
}

extension LoginAPI: TargetType {
	public var baseURL: URL {
		switch self {
		case .emailLogin, .emailCodeSent, .emailConfirm, .emailCodeConfirm:
			return GuestHouseAPIInfo.authURL
			
		case .emailSignup:
			return GuestHouseAPIInfo.usersURL
		}
	}
	
	public var path: String {
		switch self {
		case .emailLogin:
			return "/login"
			
		case .emailCodeSent:
			return "/email-code"
			
		case .emailConfirm:
			return "/verify/email"
			
		case .emailCodeConfirm:
			return "/email-code/confirm"
			
		case .emailSignup:
			return "/signup"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .emailLogin:
			return .post
			
		case .emailCodeSent:
			return .post
			
		case .emailConfirm:
			return .post
			
		case .emailCodeConfirm:
			return .post
			
		case .emailSignup:
			return .post
		}
	}
	
	public var task: Moya.Task {
		switch self {
		case let .emailLogin(email, password):
			return .requestParameters(
				parameters: ["email": email, "password": password],
				encoding: JSONEncoding.default
			)
			
		case let .emailCodeSent(email):
			return .requestParameters(
				parameters: ["email": email],
				encoding: JSONEncoding.default
			)
			
		case let .emailConfirm(email):
			return .requestParameters(
				parameters: ["email": email],
				encoding: JSONEncoding.default
			)
			
		case let .emailCodeConfirm(email, code):
			return .requestParameters(
				parameters: ["email": email, "code": code],
				encoding: JSONEncoding.default
			)
			
		case let .emailSignup(
			email,
			password,
			name,
			nickname,
			birth,
			avatar,
			phoneNum):
			
			var multipartFormData: [MultipartFormData] = []
			
			let parameters: [String: Any] = [
				"email": email ?? "",
				"password": password ?? "",
				"name": name ?? "",
				"nickname": nickname ?? "",
				"birth": birth ?? "",
				"phoneNum": phoneNum ?? ""
			]
			
			for (key, value) in parameters {
				multipartFormData.append(
					MultipartFormData(provider: .data("\(value)".data(using: .utf8) ?? Data()), name: key)
				)
			}
			
			multipartFormData.append(
				MultipartFormData(
					provider: .data(avatar ?? Data()),
					name: "profileImg",
					fileName: "\(name ?? "UnKnown").jpeg",
					mimeType: "image/jpeg"
				)
			)
			
			return .uploadMultipart(multipartFormData)
		}
	}
	
	public var validationType: ValidationType {
		return .successCodes
	}
	
	public var headers: [String: String]? {
		switch self {
		case .emailLogin, .emailCodeSent, .emailCodeConfirm, .emailConfirm:
			return ["Content-Type": "application/json"]
			
		case .emailSignup:
			return ["Content-Type": "multipart/form-data"]
		}
	}
}
