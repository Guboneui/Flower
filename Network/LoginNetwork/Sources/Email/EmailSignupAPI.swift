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
	case emailSignup(
		email: String?,
		password: String?,
		userName: String?,
		userNickName: String?,
		birth: String?,
		profileImg: Data?,
		phoneNum: String?)
}

extension EmailSignupAPI: TargetType {
	public var baseURL: URL {
		guard let url = URL(string: "http://43.202.77.12:8080/api/users") else {
			fatalError("Invalid base URL")
		}
		return url
	}
	
	public var path: String {
		switch self {
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
		case .emailAuth(let email):
			return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
			
		case .emailConfirm(email: let email):
			return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
			
		case .emailCode(email: let email, code: let code):
			return .requestParameters(
				parameters: ["email": email, "code": code],
				encoding: JSONEncoding.default)
			
		case .emailSignup(
			email: let email,
			password: let password,
			userName: let userName,
			userNickName: let userNickName,
			birth: let birth,
			profileImg: let profileImg,
			phoneNum: let phoneNum):
			
			var multipartFormData: [MultipartFormData] = []
			
			let email = email ?? ""
			let password = password ?? ""
			let userName = userName ?? ""
			let userNickName = userNickName ?? ""
			let birth = birth ?? ""
			let phoneNum = phoneNum ?? ""
			let profileImg = profileImg ?? Data()
			
			let parameters: [String: Any] = [
									"email": email,
									"password": password,
									"userName": userName,
									"userNickName": userNickName,
									"birth": birth,
									"phoneNum": phoneNum,
									"profileImg": profileImg
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
		case .emailAuth, .emailCode, .emailConfirm:
			return nil
			
		case .emailSignup:
			return ["Content-Type": "multipart/form-data"]
		}
	}
}
