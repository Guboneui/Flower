//
//  TestViewModel.swift
//  Login
//
//  Created by 구본의 on 2023/11/10.
//

import Foundation

import LoginDomain
import LoginEntity

import RxRelay
import RxSwift

public final class TestViewModel {
//	private let testUseCase: TestUseCaseInterface
	private let siginUpUseCase: SiginUpUseCase
	private let disposeBag: DisposeBag
	
	public var userGender: BehaviorRelay<String> = .init(value: "kuhgkhjhk")
	
	public init(siginUpUseCase: SiginUpUseCase) {
		self.siginUpUseCase = siginUpUseCase
		self.disposeBag = .init()
	}
	
	let params = EmailConfirmRequestDTO(email: "aa")
	
//	public func testViewModelMethod() {
//		siginUpUseCase.EmailConfirmUseCaseMethod(params: params)
//			.subscribe { [weak self] genter in
//				guard let self else { return }
//				self.userGender.accept(genter)
//			}.disposed(by: disposeBag)
//	}
}
