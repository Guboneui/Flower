//
//  PasswordEditView.swift
//  Profile
//
//  Created by 구본의 on 2024/03/09.
//

import UIKit

import DesignSystem
import ResourceKit
import UtilityKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class PasswordEditView: UIView {
	// MARK: - Metric
	
	// MARK: - TextSet
	private enum TextSet {
		static let navigationTitle: String = "비밀번호 변경"
	}
	
	// MARK: - UI Property
	fileprivate let navigationBar: NavigationBar = .init(
		.back,
		title: TextSet.navigationTitle
	)
	// MARK: - Property
	
	// MARK: - Initialize
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
		setupViews()
		setupBinds()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public Method
}

// MARK: - Viewable
extension PasswordEditView: Viewable {
	func setupConfigures() {
		backgroundColor = AppTheme.Color.white
	}
	
	func setupViews() {
		setupConstraints()
	}
	
	func setupConstraints() {
		snp.makeConstraints { make in
			make.height.equalTo(500)
		}
	}
	
	func setupBinds() {
		
	}
}
