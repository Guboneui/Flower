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
	public let nat: String
	public let name: Name
	
	public init(gender: String, nat: String, name: Name) {
		self.gender = gender
		self.nat = nat
		self.name = name
	}
}

public struct Name: Codable {
	public let title: String
	public let first: String
	public let last: String
}
