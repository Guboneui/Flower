//
//  ProfileSource.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2024/02/26.
//

import UIKit

import Profile
import ResourceKit
import UtilityKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class ProfileRootViewController: UIViewController {
	
	// MARK: - Metric
	private enum Metric {
		static let buttonSize: CGSize = .init(width: 100, height: 100)
	}
	
	// MARK: - UI Property
	private let button: UIButton = UIButton().then {
		$0.setTitle("Profile", for: .normal)
		$0.backgroundColor = AppTheme.Color.neutral300
	}
	
	// MARK: - Property
	private let disposeBag: DisposeBag = .init()
	
	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupConfigures()
		setupViews()
		setupBinds()
	}
}

extension ProfileRootViewController: Viewable {
	func setupConfigures() {
		view.backgroundColor = .white
	}
	
	func setupViews() {
		view.addSubview(button)
		setupConstraints()
	}
	
	func setupConstraints() {
		button.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.size.equalTo(Metric.buttonSize)
		}
	}
	
	func setupBinds() { 
		button.rx.tap
			.bind { [weak self] in
				guard let self else { return }
				let profileViewReactor: ProfileViewReactor = .init()
				let profileViewController: ProfileViewController = ProfileViewController()
				profileViewController.reactor = profileViewReactor
				let navigationController: UINavigationController = .init(
					rootViewController: profileViewController
				)
				navigationController.navigationBar.isHidden = true
				navigationController.modalPresentationStyle = .overFullScreen
				self.present(
					navigationController,
					animated: true
				)
			}.disposed(by: disposeBag)
	}
}
