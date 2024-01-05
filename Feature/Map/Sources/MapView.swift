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

	}
	
	// MARK: - UI Property
	private(set) var mapView: NMFMapView = NMFMapView()
	
	private(set) var mapCollectionView: UICollectionView = {
		var layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 8
		layout.scrollDirection = .horizontal
		layout.sectionInset = .zero
		
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .none
		cv.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		return cv
	}()
	
	private let houseListButtonView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.primary
		$0.makeCornerRadius(17, edge: .all)
		$0.layer.shadowOpacity = 0.2
		$0.layer.shadowColor = AppTheme.Color.black.cgColor
		$0.layer.shadowOffset = CGSize(width: 2, height: 2)
		$0.layer.shadowRadius = 10
		$0.layer.masksToBounds = false
	}
	
	private let hoouseListButtonImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.houseList
		$0.tintColor = AppTheme.Color.white
	}
	
	private let houseListLabel: UILabel = UILabel().then {
		$0.text = "목록보기"
		$0.font = AppTheme.Font.Regular_14
		$0.textColor = AppTheme.Color.white
	}
	
	private let userLocationButtonView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.white
		$0.makeCornerRadius(20, edge: .all)
		$0.layer.shadowOpacity = 0.2
		$0.layer.shadowColor = AppTheme.Color.black.cgColor
		$0.layer.shadowOffset = CGSize(width: 1, height: 1)
		$0.layer.shadowRadius = 10
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
		
		houseListButtonView.addSubview(hoouseListButtonImageView)
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
			make.bottom.equalToSuperview().offset(-106)
			make.height.equalTo(141)
		}
		
		houseListButtonView.snp.makeConstraints { make in
			make.width.equalTo(92)
			make.height.equalTo(33)
			make.bottom.equalTo(mapCollectionView.snp.top).offset(-12)
			make.centerX.equalToSuperview()
		}
		
		hoouseListButtonImageView.snp.makeConstraints { make in
			make.size.equalTo(16)
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(12)
		}
		
		houseListLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().offset(-12)
		}
		
		userLocationButtonView.snp.makeConstraints { make in
			make.size.equalTo(40)
			make.bottom.equalTo(mapCollectionView.snp.top).offset(-12)
			make.trailing.equalToSuperview().offset(-32)
		}
		
		userLocationImageView.snp.makeConstraints { make in
			make.size.equalTo(24)
			make.center.equalToSuperview()
		}
	}
	
	func setupBinds() {
		
	}
}
