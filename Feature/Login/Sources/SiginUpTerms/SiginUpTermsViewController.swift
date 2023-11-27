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
	private let siginUpTermsView: SiginUpTermsView = SiginUpTermsView()
	public var goSiginUpButton: DefaultButton { siginUpTermsView.goSiginUpButton }
	public var parentVC: UIViewController?
	public var backgroundView: UIView { siginUpTermsView.backgroundView }
	public var modalView: UIView { siginUpTermsView.modalView }
	
	public override func loadView() {
		view = siginUpTermsView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
	}
}

private extension SiginUpTermsViewController {
	func setupGestures() {
		backgroundView.addGestureRecognizer(UITapGestureRecognizer(
			target: self,
			action: #selector(didTapBackgroundView(_:)))
		)
		
		goSiginUpButton.addTarget(
			self,
			action: #selector(didTapGoSiginUpButton(_:)),
			for: .touchUpInside)
	}
	
	@objc func didTapBackgroundView(_ sender: UITapGestureRecognizer) {
		hideModal()
	}
	
	@objc func didTapGoSiginUpButton(_ sender: UITapGestureRecognizer) {
		let EmailSiginUpViewController = EmailSiginUpEmailViewController()
		navigationController?.pushViewController(EmailSiginUpViewController, animated: true)
		hideModal()
	}
}
