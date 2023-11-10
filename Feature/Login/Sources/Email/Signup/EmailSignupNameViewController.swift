//
//  EmailSignupNameViewController.swift
//  Login
//
//  Created by 김동겸 on 11/8/23.
//

import Foundation
import UIKit

import DesignSystem
import ResourceKit

import RxGesture
import RxSwift
import SnapKit
import Then

public final class EmailSignupNameViewController: UIViewController {
	// MARK: METRIC
	private enum Metric {
		static let nameViewHeightMargin: CGFloat = 73
		static let nameViewTopMargin: CGFloat = 60
		static let nameViewBothSidesMargin: CGFloat = 24
		
		static let nameTextFieldTopMargin: CGFloat = 8
		
		static let nextButtonBottomMargin: CGFloat = 34
		static let nextButttonBothsides: CGFloat = 24
		
		static let tapGesturemilliseconds: Int = 300
	}
	
	// MARK: FONT
	private enum Font {
		static let nameLabelFont: UIFont = .AppFont.Bold_16
		
	}
	
	// MARK: Image
	private enum Image {
	}
	
	// MARK: COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = .AppColor.appWhite
		static let nameLabelColor: UIColor = .AppColor.appBlack
		
	}
	
	// MARK: TEXTSET
	private enum TextSet {
		static let navigationBarText: String = "회원가입"
		static let nameLabelText: String = "이름을 입력해 주세요"
		static let nextButtonText: String = "다음"
	}
	
	private let navigationBar = NavigationBar(.back, title: TextSet.navigationBarText)
	
	private let imageView: UIView = UIView().then {
		$0.backgroundColor = .AppColor.appBlack
	}
	
	private let nameView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.backgroundColor
	}
	
	private let nameLabel: UILabel = UILabel().then {
		$0.text = TextSet.nameLabelText
		$0.font = Font.nameLabelFont
		$0.textColor = ColorSet.nameLabelColor
	}
	
	private let nameTextField: DefaultTextField = DefaultTextField(.name)
	
	private let nextButton: DefaultButton = DefaultButton(title: TextSet.nextButtonText)
	
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupViews()
		setupGestures()
	}
}

private extension EmailSignupNameViewController {
	func setupUI() {
		view.backgroundColor = ColorSet.backgroundColor
	}
	
	func setupViews() {
		view.addSubview(navigationBar)
		
		view.addSubview(imageView)
		
		view.addSubview(nameView)
		nameView.addSubview(nameLabel)
		nameView.addSubview(nameTextField)
		
		view.addSubview(nextButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		imageView.snp.makeConstraints { make in
			make.height.width.equalTo(108)
			make.top.equalTo(navigationBar.snp.bottom).offset(52)
			make.centerX.equalToSuperview()
		}
		
		nameView.snp.makeConstraints { make in
			make.height.equalTo(Metric.nameViewHeightMargin)
			make.top.equalTo(imageView.snp.bottom).offset(Metric.nameViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.nameViewBothSidesMargin)
		}
		
		nameLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
		}
		
		nameTextField.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(Metric.nameTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview()
		}
		
		nextButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.nextButtonBottomMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.nextButttonBothsides)
		}
	}
	
	func setupGestures() {
		navigationBar.didTapLeftButton = {
			if let navigation = self.navigationController as? EmailLoginNavigationController {
				navigation.pageController.moveToPrevPage()
				navigation.popViewController(animated: true)
			}
		}
		
		nextButton.rx.tap
			.throttle(.milliseconds(Metric.tapGesturemilliseconds), latest: false,
								scheduler: MainScheduler.instance
			)// 이 밀리초안에 첫째값만
			.bind {[weak self] in guard let self else { return }
				if let navigation = self.navigationController as? EmailLoginNavigationController {
					navigation.pageController.moveToNextPage()
					let signupPhoneVC = EmailSignupPhoneViewController()
					navigation.pushViewController(signupPhoneVC, animated: true)
				}
			}
			.disposed(by: disposeBag)
	}
}
