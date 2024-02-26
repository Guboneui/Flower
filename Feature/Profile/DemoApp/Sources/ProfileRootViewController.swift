//
//  ProfileSource.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2024/02/26.
//

import UIKit

import UtilityKit

import SnapKit
import Then

final class ProfileRootViewController: UIViewController {
	
	private let label: UILabel = UILabel().then {
		$0.text = "PROFILE MAIN"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupConfigures()
		setupViews()
	}
}

extension ProfileRootViewController: Viewable {
	func setupConfigures() {
		view.backgroundColor = .white
	}
	
	func setupViews() {
		view.addSubview(label)
		setupConstraints()
	}
	
	func setupConstraints() {
		label.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
	
	func setupBinds() { }
}
