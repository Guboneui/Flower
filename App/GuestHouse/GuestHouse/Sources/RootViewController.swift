//
//  RootViewController.swift
//  GuestHouse
//
//  Created by 구본의 on 3/26/24.
//

import UIKit

import ResourceKit

import SnapKit
import Then

final class RootViewController: UIViewController {

	private let rootLabel: UILabel = UILabel().then { label in
		label.text = "Hello World"
		label.font = AppTheme.Font.Regular_20
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}

	private func setupViews() {
		view.backgroundColor = AppTheme.Color.white

		view.addSubview(rootLabel)
		setupConstraints()
	}

	private func setupConstraints() {
		rootLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}
