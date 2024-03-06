//
//  ProfileEditViewController.swift
//  Profile
//
//  Created by 구본의 on 2024/03/06.
//

import UIKit

import DesignSystem
import ResourceKit

import ReactorKit
import RxCocoa
import RxSwift

final class ProfileEditViewController: UIViewController, ReactorKit.View{
  // MARK: - UI Property
  private let rootView: ProfileEditView = ProfileEditView()

  // MARK: - Property
	var disposeBag: DisposeBag = DisposeBag()
  
  // MARK: - LIFE CYCLE
  override func loadView() {
    view = rootView
  }
  
	func bind(reactor: ProfileEditViewReactor) {
		reactor.state
			.map { $0.nameViewModel }
			.distinctUntilChanged()
			.bind(to: rootView.rx.setNameView)
			.disposed(by: disposeBag)
		
		reactor.state
			.map { $0.emailViewModel }
			.distinctUntilChanged()
			.bind(to: rootView.rx.setEmailView)
			.disposed(by: disposeBag)
		
		reactor.state
			.map { $0.passwordViewModel }
			.distinctUntilChanged()
			.bind(to: rootView.rx.setPasswordView)
			.disposed(by: disposeBag)
		
		reactor.state
			.map { $0.phoneNumberViewModel }
			.distinctUntilChanged()
			.bind(to: rootView.rx.setPhoneNumberView)
			.disposed(by: disposeBag)
	}
}

// MARK: - Private Method
private extension ProfileEditViewController {
  
}
