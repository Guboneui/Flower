//
//  NetworkRepository.swift
//  NetworkHelper
//
//  Created by 구본의 on 2023/11/10.
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
			.map(Response.self)
	}
}
