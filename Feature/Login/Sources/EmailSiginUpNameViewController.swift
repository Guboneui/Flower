//
//  EmailSiginUpNameViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/07.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class EmailSiginUpNameViewController: UIViewController {
	private let navigationBar = NavigationBar(.back, title: "회원가입")
	
	private let profileView: UIView = UIView().then {
		$0.backgroundColor = .white
		$0.makeCornerRadiusWithBorder(54, borderWidth: 1.5, borderColor: .AppColor.appGrey70)
	}
	
	private let profileImageView: UIImageView = UIImageView().then {
		$0.image = .AppImage.profile.withRenderingMode(.alwaysTemplate)
		$0.tintColor = .AppColor.appGrey40
	}
	
	private let cameraView: UIView = UIView().then {
		$0.backgroundColor = .AppColor.appPrimary
		$0.makeCornerRadius(18)
	}
	
	private let cameraImageView: UIImageView = UIImageView().then {
		$0.image = .AppImage.camera.withRenderingMode(.alwaysTemplate)
		$0.tintColor = .white
	}
	
	private let nameLabel: UILabel = UILabel().then {
		$0.text = "이름을 입력해 주세요"
		$0.font = .AppFont.Bold_16
		$0.textColor = .AppColor.appBlack
	}
	
	private let nameTextField: DefaultTextField = DefaultTextField(.name)
	
	private let nextButton: DefaultButton = DefaultButton(title: "다음", initEnableState: true)
	
	private enum Metric {
		static let horizontalMargin = 24
		
		static let profileViewTopMargin = 52
		static let profileViewSize = 108
		static let profileImageViewSize = 48
		static let cameraViewSize = 36
		static let cameraImageViewSize = 18
		static let cameraViewRightMargin = 4
		static let cameraViewBottomMargin = 4
		
		static let nameLabelTopMargin = 60
		static let nameLabelLeftMargin = 24
		
		static let nameTextFieldTopMargin = 8
		
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
		view.addSubview(profileView)
		view.addSubview(cameraView)
		view.addSubview(nameLabel)
		view.addSubview(nameTextField)
		view.addSubview(nextButton)
		
		profileView.addSubview(profileImageView)
		cameraView.addSubview(cameraImageView)
		
		setupLayouts()
	}
	
	public func setupLayouts() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		profileView.snp.makeConstraints { make in
			make.size.equalTo(Metric.profileViewSize)
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.profileViewTopMargin)
			make.centerX.equalToSuperview()
		}
		
		profileImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.profileImageViewSize)
			make.center.equalToSuperview()
		}
		
		cameraView.snp.makeConstraints { make in
			make.size.equalTo(Metric.cameraViewSize)
			make.bottom.equalTo(profileView.snp.bottom).offset(Metric.cameraViewBottomMargin)
			make.trailing.equalTo(profileView.snp.trailing).offset(Metric.cameraViewRightMargin)
		}
		
		cameraImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.cameraImageViewSize)
			make.center.equalToSuperview()
		}
		
		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(profileView.snp.bottom).offset(Metric.nameLabelTopMargin)
			make.leading.equalToSuperview().offset(Metric.nameLabelLeftMargin)
		}
		
		nameTextField.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(Metric.nameTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
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
		if let navigation = self.navigationController as? LoginNavigationController {
			let EmailSiginUpPhoneViewController = EmailSiginUpPhoneViewController()
			navigation.pushViewController(EmailSiginUpPhoneViewController, animated: true)
			navigation.pageController.moveToNextPage()
		}
	}
}
