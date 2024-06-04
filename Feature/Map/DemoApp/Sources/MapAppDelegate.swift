//
//  MapAppDelegate.swift
//  Map
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

import Map
import MapData
import MapDomain


@main
class ChattingAppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let window = UIWindow(frame: UIScreen.main.bounds)

		let mapRepository: MapRepositoryInterface = MapRepository()
		let mapUseCase: MapUseCaseInterface = MapUseCase(MapRepository: mapRepository)
		let mapViewModel = MapViewModel(useCase: mapUseCase)
		window.rootViewController = MapViewController(mapViewModel: mapViewModel)
		window.makeKeyAndVisible()
		self.window = window
		return true
	}
}
