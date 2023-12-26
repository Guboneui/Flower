//
//  MainAppDelegate.swift
//  Main
//
//  Created by 구본의 on 2023/12/26.
//

import UIKit

import Main

@main
class LoginAppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let window = UIWindow(frame: UIScreen.main.bounds)
		let viewController: UIViewController = MainTabBarController()
		window.rootViewController = viewController
		window.makeKeyAndVisible()
		self.window = window
		return true
	}
}
