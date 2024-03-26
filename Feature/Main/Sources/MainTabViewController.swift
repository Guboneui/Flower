//
//  MainTabViewController.swift
//  MainDemoApp
//
//  Created by 구본의 on 3/26/24.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class MainTabBarController: UIViewController {
	
	// MARK: - UI Property
	private let rootView: MainTabBarView = MainTabBarView()
	
	// MARK: - Life Cycle
	public override func loadView() {
		view = rootView
	}
}
