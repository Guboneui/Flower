//
//  EmailSignupViewModel.swift
//  Login
//
//  Created by 김동겸 on 11/24/23.
//

import Foundation

import LoginDomain
import LoginEntity

import RxRelay
import RxSwift

// MARK: - VIEWMODEL INTERFACE
public protocol EmailSignupIDViewModelInterface {
	var emailRelay: BehaviorRelay<String> { get }
	var authRelay: BehaviorRelay<String> { get }
	var timerRelay: BehaviorRelay<String> { get }
	var currentViewState: BehaviorRelay<EmailSignupIDViewStateModel> { get }
	var userData: UserData { get set }
	
	func isValidEmail()
	func isValiedAuthNumber()
	func fetchEmailAuth(email: String)
	func startTimer(sec: Int)
	func stopTimer()
}

public final class EmailSignupIDViewModel: EmailSignupIDViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var emailRelay: BehaviorRelay<String> = .init(value: "")
	public var authRelay: BehaviorRelay<String> = .init(value: "")
	public var timerRelay: BehaviorRelay<String> = .init(value: "10분 00초")
	
	public var currentViewState: BehaviorRelay<EmailSignupIDViewStateModel> =
		.init(value: EmailSignupIDViewStateModel(state: .email))
	
	public var userData: UserData = .init()
	
	// MARK: - PRIVATE PROPERTY
	private let signUpUseCase: EmailSignupUseCaseInterface
	private let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
	private var disposeBag: DisposeBag
	private var timer: Disposable?
	
	// MARK: - INITIALIZE
	public init(useCase: EmailSignupUseCaseInterface) {
		self.signUpUseCase = useCase
		self.disposeBag = .init()
	}
	
	// MARK: - PUBLIC METHOD
	public func isValidEmail() {
		if currentViewState.value.state == .email {
			if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailRelay.value) {
				fetchEmailConfirm(email: emailRelay.value)
			} else {
				currentViewState.accept(.init(state: .email, enabled: false))
			}
		}
	}
	
	public func isValiedAuthNumber() {
		if currentViewState.value.state == .auth {
			if authRelay.value.count == 6 {
				fetchEmailCode(email: emailRelay.value, code: authRelay.value)
			} else {
				currentViewState.accept(.init(state: .auth, enabled: false))
			}
		}
	}
	
	public func fetchEmailAuth(email: String) {
		signUpUseCase.fetchEmailAuth(email: email)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				if response.success {
					self.currentViewState.accept(.init(state: .auth))
				}
			}).disposed(by: disposeBag)
	}
	
	public func startTimer(sec: Int) {
		stopTimer()
		
		timer = Observable<Int>
			.interval(
				.seconds(1),
				scheduler: MainScheduler.instance
			)
			.take(600)
			.subscribe(onNext: { [weak self] time in
				guard let self else { return }
				
				let minute = ((sec - time) % 3600) / 60
				let second = ((sec - time) % 3600) % 60
				
				if second < 10 {
					self.timerRelay.accept(
						String(minute) + "분 " + "0" + String(second) + "초"
					)
				} else {
					self.timerRelay.accept(
						String(minute) + "분 " + String(second) + "초"
					)
				}
			})
	}
	
	public func stopTimer() {
		timer?.dispose()
	}
}

// MARK: - PRIVATE METHOD
private extension EmailSignupIDViewModel {
	func fetchEmailConfirm(email: String) {
		signUpUseCase.fetchEmailConfirm(email: email)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				currentViewState.accept(.init(state: .email, enabled: response.success))
			}).disposed(by: disposeBag)
	}
	
	func fetchEmailCode(email: String, code: String) {
		signUpUseCase.fetchEmailCode(email: email, code: code)
			.subscribe(onSuccess: { [weak self] response in
				guard let self else { return }
				
				currentViewState.accept(.init(state: .auth, enabled: response.success))
			}).disposed(by: disposeBag)
	}
}
