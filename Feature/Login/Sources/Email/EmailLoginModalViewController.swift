//
//  EmailLoginModalViewController.swift
//  Login
//
//  Created by 김동겸 on 10/31/23.
//

import Foundation
import UIKit

import LoginData
import LoginDomain

import DesignSystem
import ResourceKit

import RxSwift
import SnapKit
import Then

final class EmailLoginModalViewController: UIViewController, DimModalPresentable {
	
	// MARK: - METRIC
	private enum Metric {
		static let signupButtonTopMargin: CGFloat = 330
		static let signupButtonBothSidesMargin: CGFloat = 24
		static let signupButtonBottomMargin: CGFloat = 34
		
		static let tapGesturemilliseconds: Int = 300
	}
	
	// MARK: - TEXTSET
	private enum TextSet {
		static let loginButtonText: String = "동의하고 회원가입 계속하기"
	}
	
	// MARK: - PUBLIC PROPERTY
	public var parentVC: UIViewController?
	public var backgroundView: UIView = UIView()
	public var modalView: UIView = UIView()
	
	// MARK: - PRIVATE PROPERTY
	private let signupButton: DefaultButton = DefaultButton(title: TextSet.loginButtonText)
	private let disposeBag = DisposeBag()
	
	// MARK: - LIFE CYCLE
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupGestures()
	}
}

// MARK: - PRIVATE METHOD
private extension EmailLoginModalViewController {
	func setupViews() {
		modalView.addSubview(signupButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		signupButton.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.signupButtonTopMargin)
			make.bottom.equalTo(modalView.safeAreaLayoutGuide).inset(34)
			make.horizontalEdges.equalToSuperview().inset(Metric.signupButtonBothSidesMargin)
		}
	}
	
	func setupGestures() {
		signupButton.rx.touchHandler()
			.bind {[weak self] in
				guard let self else { return }
				
				self.didTapButton()
			}.disposed(by: disposeBag)
		
		backgroundView.rx.tapGesture()
			.when(.recognized)
			.throttle(
				.milliseconds(Metric.tapGesturemilliseconds),
				latest: false,
				scheduler: MainScheduler.instance
			)
			.bind { [weak self] _ in
				guard let self else { return }
				
				self.didTapBackgroundView()
			}.disposed(by: disposeBag)
	}
	
	func didTapBackgroundView() {
		hideModal()
	}
	
	func didTapButton() {
		if let navigation = self.navigationController as? EmailLoginNavigationController {
			let repository = EmailSignupRepository()
			let useCase = EmailSignupUseCase(emailSignupIDRepository: repository)
			let viewModel = EmailSignupIDViewModel(useCase: useCase)
			let signupVC = EmailSignupIDViewController(emailSignupIDViewModel: viewModel)
			navigation.pushViewController(signupVC, animated: true)
		}
		
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
			self.hideModal()
		}
	}
}
