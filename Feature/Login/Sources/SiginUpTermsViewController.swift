//
//  SiginUpTermsViewController.swift
//  Login
//
//  Created by 김민희 on 2023/11/06.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class SiginUpTermsViewController: UIViewController, DimModalPresentable {
	public var parentVC: UIViewController?
	public var backgroundView: UIView = UIView()
	public var modalView: UIView = UIView()
	
	private let goSiginUpButton = DefaultButton(title: "동의하고 회원가입 계속하기")
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupSubViews()
		setupGestures()
	}
	
	private enum Metric {
		static let goSiginUpButtonHorzontalMargin = 24
		static let goSiginUpButtonBottomMargin = -34
		static let goSiginUpButtonTopMargin = 330
	}
	private func setupSubViews() {
		modalView.addSubview(goSiginUpButton)

		setupLayouts()
	}
	
	private func setupLayouts() {
		goSiginUpButton.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Metric.goSiginUpButtonHorzontalMargin)
			make.bottom.equalTo(modalView.safeAreaLayoutGuide).offset(Metric.goSiginUpButtonBottomMargin)
			make.topMargin.equalTo(Metric.goSiginUpButtonTopMargin)
		}
	}
	
	private func setupGestures() {
		backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackgroundView(_:))))
		
		goSiginUpButton.addTarget(self, action: #selector(didTapGoSiginUpButton(_:)), for: .touchUpInside)
	}
	
	@objc private func didTapBackgroundView(_ sender: UITapGestureRecognizer) {
		hideModal()
	}
	
	@objc private func didTapGoSiginUpButton(_ sender: UITapGestureRecognizer) {
		let EmailSiginUpViewController = EmailSiginUpEmailViewController()
		navigationController?.pushViewController(EmailSiginUpViewController, animated: true)

		hideModal()
	}
}
