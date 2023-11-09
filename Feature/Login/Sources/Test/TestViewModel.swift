//
//  TestViewModel.swift
//  Login
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import LoginDomain

public final class TestViewModel {
	private let testUseCase: TestUseCaseInterface
	
	public init(testUseCase: TestUseCaseInterface) {
		self.testUseCase = testUseCase
	}
	
	public func testViewModelMethod() {
		let userName = testUseCase.testUseCaseMethod()
		print("SUCCESS: \(userName)")
	}
}
