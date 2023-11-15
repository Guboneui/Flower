//
//  EmailSiginUpPhoneViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/08.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public class EmailSiginUpPhoneViewController: UIViewController {
	private let navigationBar = NavigationBar(.back, title: "회원가입")
	
	private let nameLabel: UILabel = UILabel().then {
		$0.text = "핸드폰 번호를 입력해 주세요"
		$0.font = .AppFont.Bold_20
		$0.textColor = .AppColor.appBlack
	}
	
	public let phoneNumberInputView = PhoneNumberInputView(
		with: ["010", "116", "017", "011", "018", "019"]
	)
	
	private let nextButton: DefaultButton = DefaultButton(title: "회원가입 완료", initEnableState: true)
	
	private enum Metric {
		static let horizontalMargin = 24
		static let nameLabelTopMargin = 54
		static let nextButtonBottomMargin = -34
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupSubViews()
		setupGestures()
	}
	
	private func setupViews() {
		view.backgroundColor = .AppColor.appWhite
	}
	
	public func setupSubViews() {
		view.addSubview(navigationBar)
		view.addSubview(nameLabel)
		view.addSubview(phoneNumberInputView)
		view.addSubview(nextButton)
		
		setupLayouts()
	}
	
	public func setupLayouts() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.nameLabelTopMargin)
			make.leading.equalToSuperview().offset(24)
		}
		
		phoneNumberInputView.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(36)
			make.horizontalEdges.equalToSuperview().inset(22)
		}
		
		nextButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(Metric.nextButtonBottomMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
	}
	
	public func setupGestures() {
		navigationBar.didTapLeftButton = {
			self.navigationController?.popViewController(animated: true)
			if let navigation = self.navigationController as? LoginNavigationController {
				navigation.pageController.moveToPrevPage()
			}
		}
		
		nextButton.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
	}
	
	@objc private func didTapNextButton(_ sender: UIButton) {
		self.navigationController?.popToRootViewController(animated: true)
	}
}
