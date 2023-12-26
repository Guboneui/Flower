//
//  SignupAPI.swift
//  LoginNetwork
//
//  Created by 김동겸 on 11/24/23.
//

import Foundation

import Moya

public enum UsersAPI {
	case emailLogin(email: String, password: String)
	case emailAuth(email: String)
	case emailConfirm(email: String)
	case emailCode(email: String, code: String)
	case emailSignup(
		email: String?,
		password: String?,
		userName: String?,
		userNickName: String?,
		birth: String?,
		profileImg: Data?,
		phoneNum: String?
	)
}

extension UsersAPI: TargetType {
	public var baseURL: URL { return GuestHouseAPIInfo.usersURL }
	
	public var path: String {
		switch self {
		case .emailLogin:
			return "/login"
			
		case .emailAuth:
			return "/mail/send"
			
		case .emailConfirm:
			return "/mail/confirm"
			
		case .emailCode:
			return "/mail/code"
			
		case .emailSignup:
			return "/signup"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .emailLogin:
			return .post
			
		case .emailAuth:
			return .post
			
		case .emailConfirm:
			return .post
			
		case .emailCode:
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
			
		case let .emailAuth(email):
			return .requestParameters(
				parameters: ["email": email], 
				encoding: JSONEncoding.default
			)
			
		case let .emailConfirm(email):
			return .requestParameters(
				parameters: ["email": email], 
				encoding: JSONEncoding.default
			)
			
		case let .emailCode(email, code):
			return .requestParameters(
				parameters: ["email": email, "code": code],
				encoding: JSONEncoding.default
			)
			
		case let .emailSignup(
			email,
			password,
			userName,
			userNickName,
			birth,
			profileImg,
			phoneNum):
			
			var multipartFormData: [MultipartFormData] = []
			
			let parameters: [String: Any] = [
									"email": email ?? "",
									"password": password ?? "",
									"userName": userName ?? "",
									"userNickName": userNickName ?? "",
									"birth": birth ?? "",
									"phoneNum": phoneNum ?? "",
									"profileImg": profileImg ?? Data()
							]
			
			for (key, value) in parameters {
				multipartFormData.append(
					MultipartFormData(provider: .data("\(value)".data(using: .utf8) ?? Data()), name: key)
				)
			}
			return .uploadMultipart(multipartFormData)
		}
	}
	
	public var headers: [String: String]? {
		switch self {
		case .emailLogin, .emailAuth, .emailCode, .emailConfirm:
			return nil
			
		case .emailSignup:
			return ["Content-Type": "multipart/form-data"]
		}
	}
}
