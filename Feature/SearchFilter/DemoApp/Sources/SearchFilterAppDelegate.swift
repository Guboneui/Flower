//
//  SearchFilterAppDelegate.swift
//
//  Created by 구본의 on 3/24/24.
//

import UIKit

@main
class LoginAppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = SearchFilterRootViewController()
		window.makeKeyAndVisible()
		self.window = window
		return true
	}
}
