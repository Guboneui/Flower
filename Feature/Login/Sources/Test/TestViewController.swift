//
//  TestViewController.swift
//  Login
//
//  Created by 구본의 on 2023/11/10.
//

import UIKit

import Moya
import RxCocoa
import RxSwift
import SnapKit
import Then

public class TestViewController: UIViewController {

	private let titleLabel: UILabel = UILabel()

	private let testViewModel: TestViewModel
	private let disposeBag: DisposeBag
	
	public init(testViewModel: TestViewModel) {
		self.testViewModel = testViewModel
		self.disposeBag = .init()
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
		
		testViewModel.userGender
			.bind(to: titleLabel.rx.text)
			.disposed(by: disposeBag)
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
