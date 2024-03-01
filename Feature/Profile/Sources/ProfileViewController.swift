//
//  ProfileViewController.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import UIKit

import DesignSystem
import ResourceKit

import ReactorKit
import RxCocoa
import RxSwift

public final class ProfileViewController: UIViewController, ReactorKit.View {
  // MARK: - UI Property
  private let rootView: ProfileView = ProfileView()

  // MARK: - Property
	public var disposeBag: DisposeBag = DisposeBag()
  
  // MARK: - LIFE CYCLE
	public override func loadView() {
    view = rootView
  }
  
	public func bind(reactor: ProfileViewReactor) {
		reactor.state
			.map { $0.collectionViewModel }
			.distinctUntilChanged()
			.asDriver(onErrorJustReturn: .init())
			.drive(onNext: { [weak self] viewModel in
				guard let self else { return }
				self.rootView.setupSnapShot(with: viewModel)
			}).disposed(by: disposeBag)

		reactor.action.onNext(.load)
	}
}

// MARK: - Private Method
private extension ProfileViewController {
  
}
