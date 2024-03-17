//
//  ServiceManagementCollectionViewCell.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import UIKit

import ResourceKit
import UtilityKit

import SnapKit
import Then

final class ServiceManagementCollectionViewCell: UICollectionViewCell {
	// MARK: - Metric
	private enum Metric {
		static let height: CGFloat = 41.0
		static let horizontalMargin: CGFloat = 24.0
		static let navigationButtonSize: CGSize = .init(width: 16.0, height: 16.0)
		static let cellHeaderHeight: CGFloat = 43.0
	}
	
	// MARK: - UI Property
	private let titleLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Medium_14
		$0.textColor = AppTheme.Color.neutral900
	}
	
	private let navigationButton: UIButton = UIButton(type: .system).then {
		$0.setImage(AppTheme.Image.arrowRight, for: .normal)
		$0.tintColor = AppTheme.Color.neutral300
	}
	
	private lazy var stackView: UIStackView = UIStackView(
		arrangedSubviews: [
			titleLabel,
			navigationButton
		]
	).then {
		$0.axis = .horizontal
	}
	
	// MARK: - Initialize
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public Method
	public func setupCellData(with viewModel: ServiceManagementCollectionViewCelViewModel) {
		titleLabel.text = viewModel.title
	}
}

// MARK: - Viewable
extension ServiceManagementCollectionViewCell: Viewable {
	func setupConfigures() {
		contentView.backgroundColor = AppTheme.Color.white
	}
	
	func setupViews() {
		contentView.addSubview(stackView)
		setupConstraints()
	}
	
	func setupConstraints() {
		navigationButton.snp.makeConstraints { make in
			make.size.equalTo(Metric.navigationButtonSize)
		}
		
		stackView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
			make.centerY.equalTo(contentView.snp.centerY)
		}
	}
	
	func setupBinds() { }
}

// MARK: - ServiceManagementCollectionViewCell Compositonal Layout
extension ServiceManagementCollectionViewCell {
	static func cellLayout(
		with environment: NSCollectionLayoutEnvironment
	) -> NSCollectionLayoutSection {
		// MARK: Configuration
		var configuration: UICollectionLayoutListConfiguration = .init(appearance: .plain)
		configuration.showsSeparators = false
		
		// MARK: Section
		let section: NSCollectionLayoutSection = .list(
			using: configuration,
			layoutEnvironment: environment
		)
		
		// MARK: Header
		let headerSize: NSCollectionLayoutSize = .init(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .absolute(Metric.cellHeaderHeight)
		)
		let header: NSCollectionLayoutBoundarySupplementaryItem = .init(
			layoutSize: headerSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top
		)
		
		section.boundarySupplementaryItems = [header]

		return section
	}
}
