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
	}
	
	func setupBinds() {
		
	}
}
