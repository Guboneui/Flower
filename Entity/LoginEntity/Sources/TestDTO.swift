//
//  TestDTO.swift
//  LoginEntity
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

public struct TestDTO: Codable {
	public let results: [Test]
	
	init(results: [Test]) {
		self.results = results
	}
}

public struct Test: Codable {
	public let gender: String
	
	public init(gender: String) {
		self.gender = gender
	}
}
