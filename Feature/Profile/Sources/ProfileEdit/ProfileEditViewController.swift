//
//  ProfileEditViewController.swift
//  Profile
//
//  Created by 구본의 on 2024/03/06.
//

import UIKit

import DesignSystem
import ResourceKit

import RxCocoa
import RxSwift

final class ProfileEditViewController: UIViewController {
  // MARK: - UI Property
  private let rootView: ProfileEditView = ProfileEditView()

  // MARK: - Property
  private let disposeBag: DisposeBag = DisposeBag()
  
  // MARK: - LIFE CYCLE
  override func loadView() {
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - Private Method
private extension ProfileEditViewController {
  
}
