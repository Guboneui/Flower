//
//  PasswordEditViewController.swift
//  Profile
//
//  Created by 구본의 on 2024/03/09.
//

import UIKit

import DesignSystem
import ResourceKit
import UtilityKit

import RxCocoa
import RxSwift

final class PasswordEditViewController: UIViewController, DimModalPresentable {
  // MARK: - UI Property
	var parentVC: UIViewController?
	var backgroundView: UIView = .init()
	var modalView: UIView = .init()
  private let rootView: PasswordEditView = PasswordEditView()

  // MARK: - Property
  private let disposeBag: DisposeBag = DisposeBag()
  
	
  // MARK: - LIFE CYCLE
  override func loadView() {
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//		setupViews()
  }
}

// MARK: - Viewable
extension PasswordEditViewController: Viewable {
	func setupConfigures() {
		modalView.backgroundColor = AppTheme.Color.white
	}
	
	func setupViews() {
		modalView.addSubview(rootView)
		setupConstraints()
	}
	
	func setupConstraints() {
		rootView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		
	}
	
	func setupBinds() {
		
	}
}
