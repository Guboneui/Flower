//
//  TestRepository.swift
//  LoginData
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import LoginDomain
import LoginEntity

public final class TestRepository: TestRepositoryInterface {
	public func fetchTest() -> TestDTO {
		return TestDTO(name: "유저 이름")
	}
	
	public init() { }
}
