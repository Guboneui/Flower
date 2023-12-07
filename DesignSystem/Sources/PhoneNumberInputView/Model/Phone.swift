//
//  Phone.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/11/04.
//

import Foundation

public struct PhoneNumber {
	public let first: String
	public let middle: String
	public let last: String
	
	public init(
		first: String,
		middle: String,
		last: String
	) {
		self.first = first
		self.middle = middle
		self.last = last
	}
}
