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
	
	// MARK: LifeCycle
	public override func loadView() {
		view = rootView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		let marker = NMFMarker()
		marker.position = NMGLatLng(lat: 37.3591784, lng: 127.1048319)
		marker.mapView = mapView
		marker.iconImage = NMFOverlayImage(image: AppTheme.Image.locationMarker)
		marker.width = 32
		marker.height = 32
	}
}
