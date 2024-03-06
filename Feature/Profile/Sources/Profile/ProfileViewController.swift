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
		
		reactor.pulse { $0.$router }
			.asDriver(onErrorJustReturn: nil)
			.compactMap { $0 }
			.drive { [weak self] router in
				guard let self else { return }
				switch router {
				case .profileEdit:
					let profileEditVC: ProfileEditViewController = .init()
					profileEditVC.reactor = ProfileEditViewReactor()
					self.navigationController?.pushViewController(
						profileEditVC,
						animated: true
					)
				}
			}.disposed(by: disposeBag)

		// MARK: - Action
		rootView.rx.tapEditProfileButton
			.map { .tapEditProfileButton }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
			
		reactor.action.onNext(.load)
	}
}

// MARK: - Private Method
private extension ProfileViewController {
  
}
