//
//  TestUseCaseInterface.swift
//  LoginDomain
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import LoginEntity

import RxSwift

public protocol TestUseCaseInterface {
	func testUseCaseMethod() -> Single<String>
}
