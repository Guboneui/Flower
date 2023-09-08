//
//  RootViewController.swift
//  App
//
//  Created by 구본의 on 2023/09/08.
//

import UIKit

import SnapKit
import Then

final class RootViewController: UIViewController {

	private let rootLabel: UILabel = UILabel().then { label in
		label.text = "Hello World"
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}

	private func setupViews() {
		view.backgroundColor = .white

		view.addSubview(rootLabel)
		setupConstraints()
	}

	private func setupConstraints() {
		rootLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.centerX.equalToSuperview()
		}
	}
}
