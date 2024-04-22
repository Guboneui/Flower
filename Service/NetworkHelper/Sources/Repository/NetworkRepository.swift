//
//  NetworkRepository.swift
//  NetworkHelper
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

import Moya
import RxMoya
import RxSwift

open class NetworkRepository<API: TargetType> {
	
	private let provider: NetworkProvider<API>
	
	public init(networkProvider: NetworkProvider<API>) {
		self.provider = networkProvider
	}
	
	public func request<Response: Codable>(endPoint: API) -> Single<Response> {
		provider.rx
			.request(endPoint)
			.filterSuccessfulStatusCodes()
			.map(Response.self)
			.catch { error in
				if let moyaError = error as? MoyaError,
					 let responseData = moyaError.response?.data {
					do {
						let customError = try JSONDecoder().decode(NetworkErrorModel.self, from: responseData)
						throw customError
					} catch let decodeError {
						throw decodeError
					}
				}
				throw error
			}
	}
}
