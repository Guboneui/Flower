//
//  UserScheduleCollectionViewCell.swift
//  Profile
//
//  Created by 구본의 on 2024/03/02.
//

import UIKit

import ResourceKit
import UtilityKit

import SnapKit
import Then

final class UserScheduleCollectionViewCell: UICollectionViewCell {
	// MARK: - Metric
	private enum Metric {
		static let height: CGFloat = 160.0
		static let radius: CGFloat = 10.0
		static let containerViewHorizontalMargin: CGFloat = 24.0
		static let horizontalMargin: CGFloat = 16.0
		static let titleLabelTopMargin: CGFloat = 16.0
		static let guestHouseImageViewTopMargin: CGFloat = 16.0
		static let guestHouseImageViewSize: CGSize = .init(width: 64.0, height: 64.0)
		static let guestHouseStackViewSpacing: CGFloat = 4.0
		static let checkInStackViewSpacing: CGFloat = 4.0
		static let checkOutStackViewSpacing: CGFloat = 4.0
		static let guestHouseScheduleSeparatorSize: CGSize = .init(width: 1, height: 10)
		static let guestHouseScheduleStackViewTopMargin: CGFloat = 8.0
		static let guestHousePriceLabelTopMargin: CGFloat = 4.0
		static let guestHousePriceLabelBottomMargin: CGFloat = 16.0
		static let sectionContentInsets: NSDirectionalEdgeInsets = .init(
			top: 0,
			leading: 0,
			bottom: 24.0,
			trailing: 0
		)
	}
	
	// MARK: - TextSet
	private enum TextSet {
		static let title: String = "내 일정"
		static let checkIn: String = "체크인"
		static let checkOut: String = "체크아웃"
	}
	
	// MARK: - UI Property
	private let containerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.white
		$0.makeCornerRadiusWithBorder(
			Metric.radius,
			borderColor: AppTheme.Color.background
		)
	}
	
	private let titleLabel: UILabel = UILabel().then {
		$0.text = TextSet.title
		$0.font = AppTheme.Font.Bold_16
		$0.textColor = AppTheme.Color.black
	}
	
	private let guestHouseImageView: UIImageView = UIImageView().then {
		$0.contentMode = .scaleAspectFill
		$0.backgroundColor = AppTheme.Color.primary
	}
	
	private let guestHouseNameLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Bold_14
		$0.textColor = AppTheme.Color.black
	}
	
	private let guestHouseRoomLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Medium_12
		$0.textColor = AppTheme.Color.grey40
	}
	
	private lazy var guestHouseStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			guestHouseNameLabel,
			guestHouseRoomLabel
		]
	).then {
		$0.axis = .vertical
		$0.spacing = Metric.guestHouseStackViewSpacing
	}
	
	private let checkInLabel: UILabel = UILabel().then {
		$0.text = TextSet.checkIn
		$0.font = AppTheme.Font.Medium_12
		$0.textColor = AppTheme.Color.primary
		$0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
	}
	
	private let checkInDateLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Medium_12
		$0.textColor = AppTheme.Color.primary
	}
	
	private lazy var checkInStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			checkInLabel,
			checkInDateLabel
		]
	).then {
		$0.axis = .vertical
		$0.spacing = Metric.checkInStackViewSpacing
	}
	
	private let checkOutLabel: UILabel = UILabel().then {
		$0.text = TextSet.checkOut
		$0.font = AppTheme.Font.Medium_12
		$0.textColor = AppTheme.Color.primary
	}
	
	private let checkOutDateLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Medium_12
		$0.textColor = AppTheme.Color.primary
	}
	
	private lazy var checkOutStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			checkOutLabel,
			checkOutDateLabel
		]
	).then {
		$0.axis = .vertical
		$0.spacing = Metric.checkInStackViewSpacing
	}
	
	private let guestHouseScheduleSeparatorView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.primary
	}
	
	private lazy var guestHouseScheduleStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			checkInStackView,
			guestHouseScheduleSeparatorView,
			checkOutStackView
		]
	).then {
		$0.axis = .horizontal
		$0.alignment = .center
		$0.spacing = 24
	}
	
	private let guestHousePriceLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Medium_12
		$0.textColor = AppTheme.Color.grey40
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
	public func setupCellData(with viewModel: UserScheduleCollectionViewCellViewModel) {
		guestHouseNameLabel.text = viewModel.guestHouseName
		guestHouseRoomLabel.text = viewModel.guestHouseRoomName
		checkInDateLabel.text = viewModel.checkInDate
		checkOutDateLabel.text = viewModel.checkOutDate
		guestHousePriceLabel.text = viewModel.guestHousePrice
	}
}

// MARK: - Viewable
extension UserScheduleCollectionViewCell: Viewable {
	func setupConfigures() {
		contentView.backgroundColor = AppTheme.Color.white
	}
	
	func setupViews() {
		contentView.addSubview(containerView)
		containerView.addSubview(titleLabel)
		containerView.addSubview(guestHouseImageView)
		containerView.addSubview(guestHouseStackView)
		containerView.addSubview(guestHouseScheduleStackView)
		containerView.addSubview(guestHousePriceLabel)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		containerView.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(Metric.containerViewHorizontalMargin)
		}
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.titleLabelTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
		
		guestHouseImageView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(Metric.guestHouseImageViewTopMargin)
			make.leading.equalToSuperview().offset(Metric.horizontalMargin)
			make.size.equalTo(Metric.guestHouseImageViewSize)
		}
		
		guestHouseStackView.snp.makeConstraints { make in
			make.top.equalTo(guestHouseImageView.snp.top)
			make.leading.equalTo(guestHouseImageView.snp.trailing).offset(Metric.horizontalMargin)
			make.trailing.equalToSuperview().inset(Metric.horizontalMargin)
		}
		
		guestHouseScheduleSeparatorView.snp.makeConstraints { make in
			make.size.equalTo(Metric.guestHouseScheduleSeparatorSize)
		}
		
		guestHouseScheduleStackView.snp.makeConstraints { make in
			make.top.equalTo(guestHouseStackView.snp.bottom)
				.offset(Metric.guestHouseScheduleStackViewTopMargin)
			make.leading.equalTo(guestHouseStackView.snp.leading)
			make.trailing.equalToSuperview().inset(Metric.horizontalMargin)
		}
		
		guestHousePriceLabel.snp.makeConstraints { make in
			make.top.equalTo(guestHouseScheduleStackView.snp.bottom)
				.offset(Metric.guestHousePriceLabelTopMargin)
			make.leading.equalTo(guestHouseStackView.snp.leading)
			make.trailing.equalToSuperview().inset(Metric.horizontalMargin)
			make.bottom.equalToSuperview().inset(Metric.guestHousePriceLabelBottomMargin)
		}
	}
	
	func setupBinds() { }
}

// MARK: - UserScheduleCollectionViewCell Compositonal Layout
extension UserScheduleCollectionViewCell {
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
			heightDimension: .estimated(Metric.height)
		)
		let group: NSCollectionLayoutGroup = .horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		// MARK: Section
		let section: NSCollectionLayoutSection = .init(group: group)
		section.contentInsets = Metric.sectionContentInsets
		return section
	}
}
