//
//  TestRepository.swift
//  LoginData
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import LoginDomain
import LoginEntity
import LoginNetwork
import NetworkHelper

import RxSwift

public final class TestRepository: NetworkRepository<TestAPI>, TestRepositoryInterface {
		
	public func fetchTest() -> Single<TestDTO> {
		request(endPoint: .userGender)
	}
	
	public init() { 
		super.init(networkProvider: NetworkProvider())
	}
}
