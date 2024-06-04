//
//  MapView.swift
//  Map
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

import DesignSystem
import ResourceKit
import UtilityKit

import NMapsMap
import SnapKit
import Then

final class MapView: UIView {
	// MARK: - TextSet
	private enum TextSet {
		static let houseListLabelText: String = "목록보기"
		static let searchTitleLabelText: String = "어떤 게스트 하우스를 찾으시나요?"
		static let searchSubTitleLabelText: String = "게스트 하우스 위치, 여행 기간, 인원 수를 설정할 수 있어요"
		static let filterButtonViewText: String = "필터"
		static let dateFilterButtonViewText: String = "2023. 12. 31 - 01. 02"
		static let peopleFilterButtonViewText: String = "2명"
	}
	
	// MARK: - Metric
	private enum Metric {
		static let mapCollectionViewItemSize: CGFloat = 1
		static let mapCollectionViewGroupWidthSize: CGFloat = 0.9
		static let mapCollectionViewGroupHeightSize: CGFloat = 1
		static let mapCollectionViewHorizontalInset: CGFloat = 4
		static let houseListButtonViewCornerRadius: CGFloat = 17
		static let houseListButtonViewShadowOffset: CGFloat = 2
		static let houseListButtonViewShadowRadius: CGFloat = 10
		static let userLocationButtonViewCornerRadius: CGFloat = 20
		static let userLocationButtonViewShadowRadius: CGFloat = 10
		static let mapCollectionViewBottomMargin: CGFloat = -106
		static let mapCollectionViewHeightSize: CGFloat = 141
		static let houseListButtonViewWidthSize: CGFloat = 92
		static let houseListButtonViewHeightSize: CGFloat = 33
		static let houseListButtonViewBottomMargin: CGFloat = -12
		static let hoouseListButtonImageViewSize: CGFloat = 16
		static let hoouseListButtonImageViewLeftMargin: CGFloat = 12
		static let houseListLabelRightMargin: CGFloat = -12
		static let userLocationButtonViewSize: CGFloat = 40
		static let userLocationButtonViewBottomMargin: CGFloat = -12
		static let userLocationButtonViewRightMargin: CGFloat = -32
		static let userLocationImageViewSize: CGFloat = 24
		static let searchViewBorderWidth: CGFloat = 0
		static let searchViewShadowOffsetWidth: CGFloat = 0
		static let searchViewShadowOffsetHeight: CGFloat = 4
		static let searchViewshadowOpacity: Float = 0.15
		static let searchButtonViewCornerRadius: CGFloat = 12
		static let searchButtonViewBorder: CGFloat = 1
		static let searchViewBottomMargin: CGFloat = 8
		static let searchViewShadowRadius: CGFloat = 10
		static let searchButtonViewTopMargin: CGFloat = 6
		static let searchButtonViewHorizontalInset: CGFloat = 24
		static let searchButtonViewHeightSize: CGFloat = 52
		static let searchImageViewSize: CGFloat = 24
		static let searchImageViewLeftMargin: CGFloat = 18
		static let searchImageViewVerticalInset: CGFloat = 14
		static let filterScrollViewTopMargin: CGFloat = 12
		static let searchTitleStackViewSpacing: CGFloat = 2
		static let filterStackViewSpacing: CGFloat = 8
		static let searchTitleStackViewLeftMargin: CGFloat = 8
		static let searchTitleStackViewRightMargin: CGFloat = -18
		static let filterScrollViewHeightSize: CGFloat = 32
	}
	
	// MARK: - UI Property
	private(set) var mapView: NMFMapView = NMFMapView( )

	private let mapCollectionViewLayout: UICollectionViewCompositionalLayout = {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(Metric.mapCollectionViewItemSize),
			heightDimension: .fractionalHeight(Metric.mapCollectionViewItemSize)
			)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(Metric.mapCollectionViewGroupWidthSize),
			heightDimension: .fractionalHeight(Metric.mapCollectionViewGroupHeightSize)
			)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		group.contentInsets.trailing = Metric.mapCollectionViewHorizontalInset
		group.contentInsets.leading = Metric.mapCollectionViewHorizontalInset
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .groupPagingCentered
		let layout = UICollectionViewCompositionalLayout(section: section)
		
		return layout
	}()
	
	private(set) lazy var mapCollectionView: UICollectionView = UICollectionView(
		frame: .zero,
		collectionViewLayout: mapCollectionViewLayout
	).then {
		$0.backgroundColor = .none
		$0.register(
			MapCollectionViewCell.self,
			forCellWithReuseIdentifier: MapCollectionViewCell.identifier
		)
		$0.showsHorizontalScrollIndicator = false
		$0.showsVerticalScrollIndicator = false
		$0.alwaysBounceVertical = false
	}
	
	private(set) var houseListButtonView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.primary
		$0.makeCornerRadius(Metric.houseListButtonViewCornerRadius, edge: .all)
		$0.makeShadow(
			offset: CGSize(
				width: Metric.houseListButtonViewShadowOffset,
				height: Metric.houseListButtonViewShadowOffset
			),
			radius: Metric.houseListButtonViewShadowRadius
		)
	}
	
	private let houseListButtonImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.houseList
		$0.tintColor = AppTheme.Color.white
	}
	
	private(set) var houseListLabel: UILabel = UILabel().then {
		$0.text = TextSet.houseListLabelText
		$0.font = AppTheme.Font.Regular_14
		$0.textColor = AppTheme.Color.white
	}
	
	private(set) var userLocationButtonView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.white
		$0.makeCornerRadius(Metric.userLocationButtonViewCornerRadius, edge: .all)
		$0.makeShadow(radius: Metric.userLocationButtonViewShadowRadius)
	}
	
	private let userLocationImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.userLocation
	}
	
	// MARK: 상단 검색 바
	private let searchView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.white
		$0.layer.borderWidth = Metric.searchViewBorderWidth
		$0.makeShadow(
			opacity: Metric.searchViewshadowOpacity,
			offset: CGSize(
				width: Metric.searchViewShadowOffsetWidth,
				height: Metric.searchViewShadowOffsetHeight
			),
			radius: Metric.searchViewShadowRadius
		)
	}
	
	private let searchButtonView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.white
		$0.makeCornerRadiusWithBorder(
			Metric.searchButtonViewCornerRadius,
			borderWidth: Metric.searchButtonViewBorder,
			borderColor: AppTheme.Color.neutral100
		)
	}
	
	private let searchImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.search
		$0.tintColor = AppTheme.Color.neutral900
	}

	private let searchTitleStackView: UIStackView = UIStackView().then {
		$0.axis = .vertical
		$0.spacing = Metric.searchTitleStackViewSpacing
	}

	private let searchTitleLabel: UILabel = UILabel().then {
		$0.text = TextSet.searchTitleLabelText
		$0.textColor = AppTheme.Color.neutral900
		$0.font = AppTheme.Font.Bold_12
	}
	
	private let searchSubTitleLabel: UILabel = UILabel().then {
		$0.text = TextSet.searchSubTitleLabelText
		$0.textColor = AppTheme.Color.neutral300
		$0.font = AppTheme.Font.Regular_10
	}

	private let filterButtonView = FilterButton(
		icon: AppTheme.Image.filter,
		title: TextSet.filterButtonViewText,
		initSelectedState: false
	)
	
	private let dateFilterButtonView = FilterButton(
		icon: AppTheme.Image.calendar,
		title: TextSet.dateFilterButtonViewText,
		initSelectedState: true
	)
	
	private let peopleFilterButtonView = FilterButton(
		icon: AppTheme.Image.enableUser,
		title: TextSet.peopleFilterButtonViewText,
		initSelectedState: true
	)

	private let filterStackView: UIStackView = UIStackView().then {
		$0.axis = .horizontal
		$0.spacing = Metric.filterStackViewSpacing
	}

	private let filterScrollView: UIScrollView = UIScrollView().then {
		$0.showsHorizontalScrollIndicator = false
		$0.showsVerticalScrollIndicator = false
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
		addSubview(mapView)
		addSubview(mapCollectionView)
		addSubview(houseListButtonView)
		addSubview(userLocationButtonView)
		addSubview(searchView)

		houseListButtonView.addSubview(houseListButtonImageView)
		houseListButtonView.addSubview(houseListLabel)

		userLocationButtonView.addSubview(userLocationImageView)

		searchView.addSubview(searchButtonView)
		searchView.addSubview(filterScrollView)
		filterScrollView.addSubview(filterStackView)

		filterStackView.addArrangedSubview(filterButtonView)
		filterStackView.addArrangedSubview(dateFilterButtonView)
		filterStackView.addArrangedSubview(peopleFilterButtonView)

		searchButtonView.addSubview(searchImageView)
		searchButtonView.addSubview(searchTitleStackView)
		searchTitleStackView.addArrangedSubview(searchTitleLabel)
		searchTitleStackView.addArrangedSubview(searchSubTitleLabel)

		setupConstraints()
	}

	func setupConstraints() {
		mapView.snp.makeConstraints { make in
			make.height.equalToSuperview()
			make.width.equalToSuperview()
		}

		mapCollectionView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalToSuperview().offset(Metric.mapCollectionViewBottomMargin)
			make.height.equalTo(Metric.mapCollectionViewHeightSize)
		}

		houseListButtonView.snp.makeConstraints { make in
			make.width.equalTo(Metric.houseListButtonViewWidthSize)
			make.height.equalTo(Metric.houseListButtonViewHeightSize)
			make.bottom.equalTo(mapCollectionView.snp.top).offset(Metric.houseListButtonViewBottomMargin)
			make.centerX.equalToSuperview()
		}

		houseListButtonImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.hoouseListButtonImageViewSize)
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(Metric.hoouseListButtonImageViewLeftMargin)
		}

		houseListLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().offset(Metric.houseListLabelRightMargin)
		}

		userLocationButtonView.snp.makeConstraints { make in
			make.size.equalTo(Metric.userLocationButtonViewSize)
			make.bottom.equalTo(mapCollectionView.snp.top).offset(Metric.userLocationButtonViewBottomMargin)
			make.trailing.equalToSuperview().offset(Metric.userLocationButtonViewRightMargin)
		}

		userLocationImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.userLocationImageViewSize)
			make.center.equalToSuperview()
		}

		// MARK: 상단 검색 바
		searchView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(filterScrollView.snp.bottom).offset(Metric.searchViewBottomMargin)
		}

		searchButtonView.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Metric.searchButtonViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.searchButtonViewHorizontalInset)
			make.height.equalTo(Metric.searchButtonViewHeightSize)
		}

		searchImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.searchImageViewSize)
			make.leading.equalToSuperview().offset(Metric.searchImageViewLeftMargin)
			make.verticalEdges.equalToSuperview().inset(Metric.searchImageViewVerticalInset)
		}

		searchTitleStackView.snp.makeConstraints { make in
			make.leading.equalTo(searchImageView.snp.trailing).offset(Metric.searchTitleStackViewLeftMargin)
			make.trailing.equalToSuperview().offset(Metric.searchTitleStackViewRightMargin)
			make.centerY.equalToSuperview()
		}

		filterScrollView.snp.makeConstraints { make in
			make.top.equalTo(searchButtonView.snp.bottom).offset(Metric.filterScrollViewTopMargin)
			make.leading.equalTo(searchButtonView.snp.leading)
			make.trailing.equalTo(searchButtonView.snp.trailing)
			make.height.equalTo(Metric.filterScrollViewHeightSize)
		}

		filterStackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
