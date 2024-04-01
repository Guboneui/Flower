//
//  MapViewController.swift
//  Map
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

import DesignSystem
import ResourceKit

import NMapsMap
import RxSwift

public final class MapViewController: UIViewController {
	// MARK: - UI Property
	private let rootView: MapView = MapView()
	private var mapView: NMFMapView { rootView.mapView }
	private var mapCollectionView: UICollectionView { rootView.mapCollectionView }
	private var houseListButtonView: UIView { rootView.houseListButtonView }
	private var houseListLabel: UILabel { rootView.houseListLabel }
	private var userLocationButtonView: UIView { rootView.userLocationButtonView }

	private var mapViewModel: MapViewModel = MapViewModel()
	
	// MARK: LifeCycle
	public override func loadView() {
		view = rootView
	}
	
	private let disposeBag = DisposeBag()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
		setupBinds()
		
		//TODO: 리스트 형태로 넣을 수 있도록 변경해야함
		let marker = NMFMarker()
		marker.position = NMGLatLng(lat: 37.3591784, lng: 127.1048319)
		marker.mapView = mapView
		marker.iconImage = NMFOverlayImage(image: AppTheme.Image.locationMarker)
		marker.width = 32
		marker.height = 32
	}
}

private extension MapViewController {
	func setupGestures() {
		houseListButtonView.rx.tapGesture()
					.when(.recognized)
					.throttle(
						.milliseconds(300),
						latest: false,
						scheduler: MainScheduler.instance
					)
					.bind { [weak self] _ in
						guard let self else { return }
						//TODO: 목록 페이지로 이동
						
					}.disposed(by: disposeBag)
		
		userLocationButtonView.rx.tapGesture()
			.when(.recognized)
				.throttle(
					.milliseconds(300),
					latest: false,
					scheduler: MainScheduler.instance
				)
				.bind { [weak self] _ in
					guard let self else { return }
					//TODO: 현재위치로 이동
				}.disposed(by: disposeBag)
	}
	
	func setupBinds() {
		mapViewModel.mapCollectionViewItems
			.observe(on: MainScheduler.instance)
			.bind(to: mapCollectionView.rx.items(
				cellIdentifier: MapCollectionViewCell.identifier,
				cellType: MapCollectionViewCell.self)
			) { indexPath, spotInfo, cell in

			}.disposed(by: disposeBag)
	}
}
