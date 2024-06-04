//
//  MapAPI.swift
//  MapService
//
//  Created by 김민희 on 6/5/24.
//

import Foundation

import Moya

public enum MapAPI {
	case accommodationList
}

extension MapAPI: TargetType {
	public var baseURL: URL {
		guard let url = URL(string: "http://52.78.141.54/") else {
			fatalError("Invalid base URL")
		}
		return url
	}

	public var path: String {
		switch self {
		case .accommodationList:
			return "v1/accommodations"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .accommodationList:
			return .get
		}

	}
	
	public var task: Moya.Task {
		switch self {
		case .accommodationList:
			return .requestPlain
		}

	}
	//TODO: 토큰 길이 때문에 린트 해제했슴다. 나중에 없애겠슴!
	// swiftlint:disable all
	public var headers: [String: String]? {
		switch self {
		case .accommodationList:
			return ["Authorization": "Bearer 토큰"]
		}

	}
	// swiftlint:enable all

}
