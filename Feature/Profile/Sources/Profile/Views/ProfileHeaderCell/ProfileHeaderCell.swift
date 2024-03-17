//
//  ProfileHeaderCell.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import UIKit

import ResourceKit
import UtilityKit

import SnapKit
import Then

public final class ProfileHeaderCell: UICollectionReusableView {
	// MARK: - Metric
	private enum Metric {
		static let horizontalMargin: CGFloat = 24.0
	}
	
	// MARK: - UI Property
	private let titleLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Bold_16
		$0.textColor = AppTheme.Color.neutral900
	}
	
	// MARK: - Initialize
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public Method
	public func setupTitle(with title: String) {
		titleLabel.text = title
	}
}

extension ProfileHeaderCell: Viewable {
	public func setupConfigures() {
		backgroundColor = AppTheme.Color.white
	}
	
	public func setupViews() {
		addSubview(titleLabel)
		setupConstraints()
	}
	
	public func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
			make.centerY.equalTo(snp.centerY)
		}
	}
	
	public func setupBinds() { }
}
