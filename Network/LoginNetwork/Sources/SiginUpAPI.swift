//
//  SiginUpAPI.swift
//  LoginNetwork
//
//  Created by 김민희 on 2023/11/29.
//

import Foundation

import LoginEntity

import Moya

public enum SiginUpAPI {
	case emailConfirm(parameters: EmailConfirmRequestDTO)
	case sendAuthCode(parameters: SendAuthCodeRequestDTO)
	case authCodeConfirm(parameters: AuthCodeConfirmRequestDTO)
}

extension SiginUpAPI: TargetType {
	public var baseURL: URL {
		guard let url = URL(string: "http://43.202.77.12:8080") else {
			fatalError("Invalid base URL")
		}
		return url
	}
	
	public var path: String {
		switch self {
		case .emailConfirm:
			return "/api/users/mail/confirm"
		case .sendAuthCode:
			return "/api/users/mail/send"
		case .authCodeConfirm:
			return "/api/users/mail/code"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .emailConfirm:
			return .post
		case .sendAuthCode:
			return .post
		case .authCodeConfirm:
			return .post
		}
	}
	
	public var task: Moya.Task {
		switch self {
		case .emailConfirm(let parameters):
			let params: [String: Any] = [
				"email": parameters.email
			]
			return .requestParameters(parameters: params, encoding: JSONEncoding.default)
		case .sendAuthCode(let parameters):
			let params: [String: Any] = [
				"email": parameters.email
			]
			return .requestParameters(parameters: params, encoding: JSONEncoding.default)
		case .authCodeConfirm(let parameters):
			let params: [String: Any] = [
				"email": parameters.email,
				"code": parameters.code
			]
			return .requestParameters(parameters: params, encoding: JSONEncoding.default)
		}
	}
	
	public var headers: [String: String]? {
		switch self {
		case .emailConfirm:
			return nil
		case .sendAuthCode:
			return nil
		case .authCodeConfirm:
			return nil
		}
	}
}
