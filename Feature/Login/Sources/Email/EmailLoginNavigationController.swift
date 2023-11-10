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
	public let pageController = PageController(
		pageCount: 4,
		defaultControllerSize: .init(width: 8, height: 8),
		selectedControllerHeight: 10
	)
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(pageController)
		pageController.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(70)
			make.centerX.equalToSuperview()
		}
	}
}
