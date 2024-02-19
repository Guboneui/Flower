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
	}
	
	// MARK: - Metric
	private enum Metric {
		static let mapCollectionViewSpacing: CGFloat = 8
		static let mapCollectionViewInsetTop: CGFloat = 0
		static let mapCollectionViewInsetleft: CGFloat = 8
		static let mapCollectionViewInsetBottom: CGFloat = 0
		static let mapCollectionViewInsetRight: CGFloat = 8
		static let houseListButtonViewCornerRadius: CGFloat = 17
		static let houseListButtonViewShadowOpacity: Float = 0.2
		static let houseListButtonViewShadowOffset: CGFloat = 2
		static let houseListButtonViewShadowRadius: CGFloat = 10
		static let userLocationButtonViewCornerRadius: CGFloat = 20
		static let userLocationButtonViewShadowOpacity: Float = 0.2
		static let userLocationButtonViewShadowOffset: CGFloat = 1
		static let userLocationButtonViewShadowRadius: CGFloat = 10
		static let mapCollectionViewBottomMargin: CGFloat = -106
		static let mapCollectionViewHeightMargin: CGFloat = 141
		static let houseListButtonViewWidthMargin: CGFloat = 92
		static let houseListButtonViewHeightMargin: CGFloat = 33
		static let houseListButtonViewBottomMargin: CGFloat = -12
		static let hoouseListButtonImageViewSize: CGFloat = 16
		static let hoouseListButtonImageViewLeftMargin: CGFloat = 12
		static let houseListLabelRightMargin: CGFloat = -12
		static let userLocationButtonViewSize: CGFloat = 40
		static let userLocationButtonViewBottomMargin: CGFloat = -12
		static let userLocationButtonViewRightMargin: CGFloat = -32
		static let userLocationImageViewSize: CGFloat = 24
	}
	
	// MARK: - UI Property
	private(set) var mapView: NMFMapView = NMFMapView()
	
	private(set) var mapCollectionView: UICollectionView = {
		var layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = Metric.mapCollectionViewSpacing
		layout.scrollDirection = .horizontal
		layout.sectionInset = .zero
		
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .none
		cv.contentInset = UIEdgeInsets(
			top: Metric.mapCollectionViewInsetTop,
			left: Metric.mapCollectionViewInsetleft,
			bottom: Metric.mapCollectionViewInsetBottom,
			right: Metric.mapCollectionViewInsetRight
		)
		cv.showsHorizontalScrollIndicator = false
		return cv
	}()
	
	private(set) var houseListButtonView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.primary
		$0.makeCornerRadius(Metric.houseListButtonViewCornerRadius, edge: .all)
		$0.layer.shadowOpacity = Metric.houseListButtonViewShadowOpacity
		$0.layer.shadowColor = AppTheme.Color.black.cgColor
		$0.layer.shadowOffset = CGSize(
			width: Metric.houseListButtonViewShadowOffset,
			height: Metric.houseListButtonViewShadowOffset
		)
		$0.layer.shadowRadius = Metric.houseListButtonViewShadowRadius
		$0.layer.masksToBounds = false
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
		$0.layer.shadowOpacity = Metric.userLocationButtonViewShadowOpacity
		$0.layer.shadowColor = AppTheme.Color.black.cgColor
		$0.layer.shadowOffset = CGSize(
			width: Metric.userLocationButtonViewShadowOffset,
			height: Metric.userLocationButtonViewShadowOffset
		)
		$0.layer.shadowRadius = Metric.userLocationButtonViewShadowRadius
		$0.layer.masksToBounds = false
	}
	
	private let userLocationImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.userLocation
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
		
		houseListButtonView.addSubview(houseListButtonImageView)
		houseListButtonView.addSubview(houseListLabel)
		
		userLocationButtonView.addSubview(userLocationImageView)
		
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
			make.height.equalTo(Metric.mapCollectionViewHeightMargin)
		}
		
		houseListButtonView.snp.makeConstraints { make in
			make.width.equalTo(Metric.houseListButtonViewWidthMargin)
			make.height.equalTo(Metric.houseListButtonViewHeightMargin)
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
	}
	
	func setupBinds() {
		
	}
}
