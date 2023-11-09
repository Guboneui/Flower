//
//  NetworkLogPlugin.swift
//  NetworkHelper
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import Moya

public struct NetworkLogPlugin: PluginType {
	public func willSend(
		_ request: RequestType,
		target: TargetType
	) {
		printRequestMessage(from: target)
	}
	
	public func didReceive(
		_ result: Result<Response, MoyaError>,
		target: TargetType
	) {
		switch result {
		case let .success(response):
			printSuccessMessage(from: response, with: target)
		case let.failure(error):
			printErrorMessage(from: error, with: target)
		}
	}
	
	public init() {}
}

extension NetworkLogPlugin {
	private func printRequestMessage(from target: TargetType) {
		let requestInfo = self.requestInfo(from: target)
		let message = "REQUEST: \(requestInfo)"
		print(message)
	}
	
	private func printSuccessMessage(
		from response: Response,
		with target: TargetType
	) {
		let requestInfo = self.requestInfo(from: target)
		let message = "SUCCESS: \(requestInfo) (\(response.description))"
		print(message)
	}
	
	private func printErrorMessage(
		from error: MoyaError,
		with target: TargetType
	) {
		let requestInfo = self.requestInfo(from: target)
		let errorDescription = error.errorDescription ?? ""
		let message = "FAILURE: \(requestInfo) \(errorDescription)"
		print(message)
	}
	
	private func requestInfo(from target: TargetType) -> String {
		let info = "\(target.method.rawValue) \(target.path)"
		return info
	}
}
