//
//  CollectionViewSeparateLineCell.swift
//  DesignSystem
//
//  Created by 구본의 on 2024/03/01.
//

import UIKit

import ResourceKit
import UtilityKit

public struct CollectionViewSeparateLineCellViewModel: Hashable { 
	public init() { }
}

public final class CollectionViewSeparateLineCell: UICollectionViewCell {
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CollectionViewSeparateLineCell: Viewable {
	public func setupConfigures() {
		contentView.backgroundColor = AppTheme.Color.background
	}
	
	public func setupViews() { }
	
	public func setupConstraints() { }
	
	public func setupBinds() { }
}

// MARK: - CollectionViewSeparateLineCell Compositonal Layout
extension CollectionViewSeparateLineCell {
	public static func cellLayout(height: CGFloat) -> NSCollectionLayoutSection {
		let itemSize: NSCollectionLayoutSize = .init(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1.0)
		)
		let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
		
		let groupSize: NSCollectionLayoutSize = .init(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .absolute(height)
		)
		let group: NSCollectionLayoutGroup = .horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		let section: NSCollectionLayoutSection = .init(group: group)
		section.orthogonalScrollingBehavior = .none
		return section
	}
}
