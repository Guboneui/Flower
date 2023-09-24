//
//  RootViewController.swift
//  App
//
//  Created by 구본의 on 2023/09/08.
//

import UIKit

import ResourceKit

import SnapKit
import Then

final class RootViewController: UIViewController {

	private let rootLabel: UILabel = UILabel().then { label in
		label.text = "Hello World!"
		label.font = .FlowerFont.medium.font(size: 20)
	}

	private let rootImageView: UIImageView = UIImageView().then { imageView in
		imageView.image = .FlowerImage.jjangu
		imageView.contentMode = .scaleAspectFit
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}

	private func setupViews() {
		view.backgroundColor = .FlowerColor.primaryColor

		view.addSubview(rootImageView)
		view.addSubview(rootLabel)
		setupConstraints()
	}

	private func setupConstraints() {
		rootImageView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.centerX.equalToSuperview()
		}

		rootLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalTo(rootImageView.snp.top).offset(-20)
		}
	}
}
