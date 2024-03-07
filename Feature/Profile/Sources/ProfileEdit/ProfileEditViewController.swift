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

final class ProfileEditViewController: UIViewController, ReactorKit.View {
  // MARK: - UI Property
  private let rootView: ProfileEditView = ProfileEditView()

  // MARK: - Property
	var disposeBag: DisposeBag = DisposeBag()
  
  // MARK: - LIFE CYCLE
  override func loadView() {
    view = rootView
  }
  
	func bind(reactor: ProfileEditViewReactor) {
		reactor.pulse { $0.$router }
			.asDriver(onErrorJustReturn: nil)
			.compactMap { $0 }
			.drive { [weak self] router in
				guard let self else { return }
				switch router {
				case .back:
					self.navigationController?.popViewController(animated: true)
				case .editProfileImage:
					print("MOVE TO EDIT PROFILE IMAGE")
				case .editEmail:
					print("MOVE TO EDIT EMAIL")
				case .editPassword:
					print("MOVE TO EDIT PASSWORD")
				case .editPhoneNumber:
					print("MOVE TO EDIT PHONENUMBER")
				}
			}.disposed(by: disposeBag)
		
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
		
		// MARK: - Action
		rootView.rx.tapBackButton
			.map { .tapNavigationButton }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		rootView.rx.tapEditProfileImageButton
			.map { .tapProfileImageEditButton }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		rootView.rx.tapEmailEditButton
			.map { .tapEmailEditButton }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		rootView.rx.tapPasswordEditButton
			.map { .tapPasswordEditButton }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		rootView.rx.tapPhoneNumberEditButton
			.map { .tapPhoneNumberEditButton }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
	}
}

// MARK: - Private Method
private extension ProfileEditViewController {
  
}
