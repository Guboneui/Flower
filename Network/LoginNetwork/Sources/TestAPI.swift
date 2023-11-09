//
//  TestAPI.swift
//  LoginNetwork
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import Moya

public enum TestAPI {
	case userGender
}

extension TestAPI: TargetType {
	public var baseURL: URL {
		guard let url = URL(string: "https://randomuser.me/api/") else {
			fatalError("Invalid base URL")
		}
		return url
	}
	
	public var path: String {
		""
	}
	
	public var method: Moya.Method {
		.get
	}
	
	public var task: Moya.Task {
		.requestPlain
	}
	
	public var headers: [String: String]? {
		nil
	}
}
