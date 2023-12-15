//
//  EmailLoginNavigationController.swift
//  Login
//
//  Created by 김동겸 on 11/9/23.
//

import UIKit

import DesignSystem

import SnapKit

public class EmailLoginNavigationController: UINavigationController {
	// MARK: - METRIC
	private enum Metric {
		static let pageControllerPageCount: Int = 4
		static let pageControllerDefaulSize: CGFloat = 8
		static let pageControllerSelectedHeight: CGFloat = 10
		static let pageControllerTopMargin: CGFloat = 70
	}
	
	// MARK: - PUBLIC PROPERTY
	public let pageController = PageController(
		pageCount: Metric.pageControllerPageCount,
		defaultControllerSize: .init(
			width: Metric.pageControllerDefaulSize,
			height: Metric.pageControllerDefaulSize),
		selectedControllerHeight: Metric.pageControllerSelectedHeight
	)
	
	// MARK: - LIFE CYCLE
	public override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(pageController)
		
		pageController.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(
				Metric.pageControllerTopMargin)
			make.centerX.equalToSuperview()
		}
	}
}
