//
//  ChattingAppDelegate.swift
//  ChattingDemoApp
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

@main
class ChattingAppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = ChattingDemoAppRootViewController()
		window.makeKeyAndVisible()
		self.window = window
		return true
	}
}
