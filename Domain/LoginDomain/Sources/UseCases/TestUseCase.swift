//
//  TestUseCase.swift
//  LoginDomain
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import LoginEntity

import RxSwift

public final class TestUseCase: TestUseCaseInterface {
	
	private let testRepository: TestRepositoryInterface
	
	public init(testRepository: TestRepositoryInterface) {
		self.testRepository = testRepository
	}
	
	public func testUseCaseMethod() -> Single<String> {
		return testRepository.fetchTest().map { $0.results[0].gender }
	}
}
