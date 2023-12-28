//
//  MapViewController.swift
//  Map
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

public final class MapViewController: UIViewController {
	
	// MARK: - UI Property
	private let rootView: MapView = MapView()
	
	// MARK: LifeCycle
	public override func loadView() {
		view = rootView
	}
}
