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
	var emailCautionRelay: BehaviorRelay<String> { get }
	var authRelay: BehaviorRelay<String> { get }
	var timerRelay: BehaviorRelay<String> { get }
	var currentViewState: BehaviorRelay<EmailSignupIDViewStateModel> { get }
	var userSignupDTO: UserSignupDTO { get set }
	
	func isValidEmail()
	func isValiedAuthNumber()
	func fetchEmailAuth()
	func startTimer(sec: Int)
	func stopTimer()
}

public final class EmailSignupIDViewModel: EmailSignupIDViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var emailRelay: BehaviorRelay<String> = .init(value: "")
	public var emailCautionRelay: BehaviorRelay<String> = .init(value: "")
	public var authRelay: BehaviorRelay<String> = .init(value: "")
	public var timerRelay: BehaviorRelay<String> = .init(value: "10분 00초")
	
	public var currentViewState: BehaviorRelay<EmailSignupIDViewStateModel> =
		.init(value: EmailSignupIDViewStateModel(state: .email))
	
	public var userSignupDTO: UserSignupDTO
	
	// MARK: - PRIVATE PROPERTY
	private let useCase: LoginUseCaseInterface
	private let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
	private var disposeBag: DisposeBag
	private var timer: Disposable?
	
	// MARK: - INITIALIZE
	public init(useCase: LoginUseCaseInterface, userSignupDTO: UserSignupDTO) {
		self.useCase = useCase
		self.disposeBag = .init()
		self.userSignupDTO = userSignupDTO
	}
	
	// MARK: - PUBLIC METHOD
	public func isValidEmail() {
		if currentViewState.value.state == .email {
			if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailRelay.value) {
				fetchEmailConfirm()
			} else {
				currentViewState.accept(.init(state: .email, enabled: false))
			}
		}
	}
	
	public func isValiedAuthNumber() {
		if currentViewState.value.state == .auth {
			if authRelay.value.count == 6 {
				fetchEmailCode()
			} else {
				currentViewState.accept(.init(state: .auth, enabled: false))
			}
		}
	}
	
	public func fetchEmailAuth() {
		useCase.fetchEmailAuth(email: emailRelay.value)
			.subscribe(onSuccess: { [weak self] responseData in
				guard let self else { return }
				
				if responseData.success {
					self.currentViewState.accept(.init(state: .auth, enabled: nil))
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
		timer = nil
	}
}

// MARK: - PRIVATE METHOD
private extension EmailSignupIDViewModel {
	func fetchEmailConfirm() {
		useCase.fetchEmailConfirm(email: emailRelay.value)
			.subscribe(onSuccess: { [weak self] responseData in
				guard let self else { return }
				
				self.currentViewState.accept(
					.init(state: .email, enabled: responseData.success)
				)
				
				self.emailCautionRelay.accept(responseData.message)
			}).disposed(by: disposeBag)
	}
	
	func fetchEmailCode() {
		useCase.fetchEmailCode(email: emailRelay.value, code: authRelay.value)
			.subscribe(onSuccess: { [weak self] responseData in
				guard let self else { return }
				
				self.currentViewState.accept(
					.init(state: .auth, enabled: responseData.success)
				)
			}).disposed(by: disposeBag)
	}
}
