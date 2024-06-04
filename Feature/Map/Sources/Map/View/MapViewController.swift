//
//  MapViewController.swift
//  Map
//
//  Created by 구본의 on 2023/12/28.
//

import CoreLocation
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

	private var mapViewModel: MapViewModelInterface

	private let disposeBag = DisposeBag()
	let locationManager = CLLocationManager()
	private var shouldMoveCameraToCurrentLocation = true

	public init(mapViewModel: MapViewModelInterface) {
		self.mapViewModel = mapViewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: LifeCycle
	public override func loadView() {
		view = rootView
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		setupGestures()
		setupBinds()
		addMarkers()
		mapView.addCameraDelegate(delegate: self)
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		mapViewModel.fetchAccommodationList()
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
				shouldMoveCameraToCurrentLocation = true
				moveCameraToCurrentLocation()
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

	func addMarkers() {
		let markerLocations: [(latitude: Double, longitude: Double)] = [
			(37.3591, 127.1048),
			(37.5665, 126.9780), // 서울 시청
			(35.1796, 129.0756), // 부산 타워
			(37.4563, 126.7052)  // 인천
		]

		for location in markerLocations {
			let marker = NMFMarker()
			marker.position = NMGLatLng(lat: location.latitude, lng: location.longitude)
			marker.mapView = mapView
			marker.iconImage = NMFOverlayImage(image: AppTheme.Image.locationMarker)
			marker.width = 32
			marker.height = 32
		}
	}

	func moveCameraToCurrentLocation() {
		guard let location = locationManager.location else {
			print("Current location is not available.")
			return
		}
		moveCameraToLocation(location)
	}

	func moveCameraToLocation(_ location: CLLocation) {
		let latLng = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
		let cameraUpdate = NMFCameraUpdate(scrollTo: latLng)
		mapView.moveCamera(cameraUpdate)
	}
}

//MARK: - map관련 extension
extension MapViewController: NMFMapViewCameraDelegate {
	public func mapView(
		_ mapView: NMFMapView,
		cameraIsChangingByReason reason: Int
	) {
		let centerCoord = mapView.cameraPosition.target
		let zoomLevel = mapView.zoomLevel

		print("Center: \(centerCoord.lat), \(centerCoord.lng)")
		print("Zoom Level: \(zoomLevel)")

	}
}

extension MapViewController: CLLocationManagerDelegate {
	public func locationManager(
		_ manager: CLLocationManager,
		didChangeAuthorization status: CLAuthorizationStatus
	) {
		if status == .authorizedWhenInUse || status == .authorizedAlways {
			locationManager.startUpdatingLocation()
		}
	}

	public func locationManager(
		_ manager: CLLocationManager,
		didUpdateLocations locations: [CLLocation]
	) {
		if let location = locations.last, shouldMoveCameraToCurrentLocation {
			moveCameraToLocation(location)
			shouldMoveCameraToCurrentLocation = false
		}
	}
	
	public func locationManager(
		_ manager: CLLocationManager,
		didFailWithError error: Error
	) {
		print("Failed to find user's location: \(error.localizedDescription)")
	}
}
