//
//  NetworkProvider.swift
//  NetworkHelper
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import Moya

public final class NetworkProvider<Target: TargetType>: MoyaProvider<Target> {
	public override init(
		endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
		requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
		stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
		callbackQueue: DispatchQueue? = nil,
		session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
		plugins: [PluginType] = [NetworkLogPlugin()],
		trackInflights: Bool = false
	) {
		super.init(
			endpointClosure: endpointClosure,
			requestClosure: requestClosure,
			stubClosure: stubClosure,
			callbackQueue: callbackQueue,
			session: session,
			plugins: plugins,
			trackInflights: trackInflights
		)
	}
}
