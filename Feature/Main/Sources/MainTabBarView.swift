//
//  MainTabBarView.swift
//  MainDemoApp
//
//  Created by 구본의 on 3/26/24.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class MainTabBarView: UIView {
	private let titleLabel: UILabel = UILabel().then {
		$0.text = "MAIN TAB BAR"
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private Method
private extension MainTabBarView {
	func setupConfigures() {
		backgroundColor = AppTheme.Color.white
	}
	
	func setupViews() {
		addSubview(titleLabel)
		setupConstraints()
	}
	
	func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}
