//
//  LoginAppDelegate.swift
//  Login
//
//  Created by 구본의 on 2023/10/17.
//

import UIKit

import Login
import LoginData
import LoginDomain

@main
class LoginAppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
		makeWindow()
    return true
  }
}

private extension LoginAppDelegate {
	func makeWindow() {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = LoginViewController()
		window?.makeKeyAndVisible()
	}
}