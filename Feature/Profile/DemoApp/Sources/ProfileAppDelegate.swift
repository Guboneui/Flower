//
//  ProfileAppDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by 구본의 on 2024/02/26.
//

import UIKit

@main
class ProfileAppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = ProfileRootViewController()
		window.makeKeyAndVisible()
		self.window = window
		return true
	}
}
