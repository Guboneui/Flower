//
//  MapViewController.swift
//  Map
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

import ResourceKit

import NMapsMap

public final class MapViewController: UIViewController {
	
	// MARK: - UI Property
	private let rootView: MapView = MapView()
	private var mapView: NMFMapView { rootView.mapView }
	private var mapCollectionView: UICollectionView { rootView.mapCollectionView }
	
	// MARK: LifeCycle
	public override func loadView() {
		view = rootView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		mapCollectionView.dataSource = self
		mapCollectionView.delegate = self
		
		mapCollectionView.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "MapCollectionViewCell")
		
		//TODO: 리스트 형태로 넣을 수 있도록 변경해야함
		let marker = NMFMarker()
		marker.position = NMGLatLng(lat: 37.3591784, lng: 127.1048319)
		marker.mapView = mapView
		marker.iconImage = NMFOverlayImage(image: AppTheme.Image.locationMarker)
		marker.width = 32
		marker.height = 32
	}
}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	public func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: "MapCollectionViewCell",
			for: indexPath) as? MapCollectionViewCell else {
			return UICollectionViewCell()
		}
		return cell
	}
	
	public func collectionView(
						_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath
			 ) -> CGSize {
						return CGSize(width: 320, height: 141)
			 }
}
