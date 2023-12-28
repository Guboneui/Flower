//
//  ChattingViewController.swift
//  ChattingDemoApp
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

public final class ChattingViewController: UIViewController {
	// MARK: - UI Property
	private let rootView: ChattingView = ChattingView()
	
	// MARK: - LifeCycle
	public override func loadView() {
		view = rootView
	}
}
