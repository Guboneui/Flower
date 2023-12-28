//
//  MapView.swift
//  Map
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

import ResourceKit
import UtilityKit

import SnapKit
import Then

final class MapView: UIView {
	// MARK: - TextSet
	private enum TextSet {
		static let titleText: String = "Map View"
	}
	
	// MARK: - UI Property
	private let titleLabel: UILabel = UILabel().then {
		$0.text = TextSet.titleText
		$0.font = AppTheme.Font.Bold_24
	}
	
	// MARK: - Iitialize
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MapView: Viewable {
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
	
	func setupBinds() {
		
	}
}
