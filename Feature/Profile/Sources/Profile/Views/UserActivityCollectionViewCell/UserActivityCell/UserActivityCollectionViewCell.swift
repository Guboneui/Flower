//
//  UserActivityCollectionViewCell.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import UIKit

import ResourceKit
import UtilityKit

final class UserActivityCollectionViewCell: UICollectionViewCell {
	// MARK: - Metric
	private enum Metric {
		static let radius: CGFloat = 10.0
		static let stackViewSpacing: CGFloat = 4.0
		static let containerViewTopMargin: CGFloat = 8.0
		static let containerViewHorizontalMargin: CGFloat = 20.0
		static let containerViewBottomMargin: CGFloat = 24.0
		static let stackViewVerticalMargin: CGFloat = 20.0
		static let stackViewHorizontalMargin: CGFloat = 16.0
		static let cellGroupEstimatedHeight: CGFloat = 122.0
		static let cellHeaderHeight: CGFloat = 43.0
	}
	
	private enum TextSet {
		static let recentDescription: String = "최근 본 숙소"
		static let resevationDescription: String = "예약 내역"
		static let bookmarkDescription: String = "저장된 숙소"
		static let reviewDescription: String = "내가 쓴 후기"
	}
	
	// MARK: - UI Property
	private let recentView: ImageValueDescriptionStackView = .init(
		image: AppTheme.Image.visible,
		description: TextSet.recentDescription
	)
	
	private let reservationView: ImageValueDescriptionStackView = .init(
		image: AppTheme.Image.myReservation,
		description: TextSet.resevationDescription
	)
	
	private let bookmarkView: ImageValueDescriptionStackView = .init(
		image: AppTheme.Image.saveGH,
		description: TextSet.bookmarkDescription
	)
	
	private let reviewView: ImageValueDescriptionStackView = .init(
		image: AppTheme.Image.review,
		description: TextSet.reviewDescription
	)
	
	private let containerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.neutral20
		$0.makeCornerRadiusWithBorder(
			Metric.radius,
			borderColor: AppTheme.Color.neutral50
		)
	}
	
	private lazy var stackView: UIStackView = UIStackView(
		arrangedSubviews: [
			recentView,
			reservationView,
			bookmarkView,
			reviewView
		]
	).then {
		$0.axis = .horizontal
		$0.distribution = .fillEqually
		$0.spacing = Metric.stackViewSpacing
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
	public func setupCellData(with viewModel: UserActivityCollectionViewCellViewModel) {
		recentView.updateValue(with: "\(viewModel.recentCount)")
		reservationView.updateValue(with: "\(viewModel.reservationCount)")
		bookmarkView.updateValue(with: "\(viewModel.bookmarkCount)")
		reviewView.updateValue(with: "\(viewModel.reviewCount)")
	}
}

extension UserActivityCollectionViewCell: Viewable {
	func setupConfigures() {
		backgroundColor = AppTheme.Color.white
	}
	
	func setupViews() {
		addSubview(containerView)
		containerView.addSubview(stackView)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		containerView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.containerViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.containerViewHorizontalMargin)
			make.bottomMargin.equalToSuperview().inset(Metric.containerViewBottomMargin)
		}
		
		stackView.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview().inset(Metric.stackViewVerticalMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.stackViewHorizontalMargin)
		}
	}
	
	func setupBinds() { }
}

// MARK: - UserActivityCollectionViewCell Compositonal Layout
extension UserActivityCollectionViewCell {
	static func cellLayout() -> NSCollectionLayoutSection {
		// MARK: Item
		let itemSize: NSCollectionLayoutSize = .init(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1.0)
		)
		let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
		
		// MARK: Group
		let groupSize: NSCollectionLayoutSize = .init(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .absolute(Metric.cellGroupEstimatedHeight)
		)
		let group: NSCollectionLayoutGroup = .horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		// MARK: Section
		let section: NSCollectionLayoutSection = .init(group: group)
		
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
