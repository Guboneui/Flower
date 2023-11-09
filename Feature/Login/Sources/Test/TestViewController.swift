//
//  TestViewController.swift
//  Login
//
//  Created by 구본의 on 2023/11/10.
//

import UIKit

import Moya
import SnapKit
import Then

public class TestViewController: UIViewController {

	private let titleLabel: UILabel = UILabel().then {
		$0.text = "LOGIN MAIN"
	}

	private let testViewModel: TestViewModel
	
	public init(testViewModel: TestViewModel) {
		self.testViewModel = testViewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupSubViews()
		
		// MARK: - 뷰모델 메소드 호출
		testViewModel.testViewModelMethod()
	}

	private func setupViews() {
		view.backgroundColor = .systemGray
	}

	private func setupSubViews() {
		view.addSubview(titleLabel)

		setupLayouts()
	}

	private func setupLayouts() {
		titleLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}

