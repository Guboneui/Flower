//
//  AppDelegate.swift
//  App
//
//  Created by 구본의 on 2023/09/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    makeWindow()
    return true
  }
}

private extension AppDelegate {
  func makeWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = RootViewController()
    window?.makeKeyAndVisible()
  }
}
