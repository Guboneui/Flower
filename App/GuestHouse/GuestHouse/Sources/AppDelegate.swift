//
//  AppDelegate.swift
//  GuestHouse
//
//  Created by 구본의 on 3/26/24.
//

import UIKit
import Map
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		makeWindow()
		return true
	}
}

private extension AppDelegate {
	func makeWindow() {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = MapViewController()
		window?.makeKeyAndVisible()
	}
}
