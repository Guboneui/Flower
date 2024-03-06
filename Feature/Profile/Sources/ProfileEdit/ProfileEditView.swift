//
//  ProfileEditView.swift
//  Profile
//
//  Created by 구본의 on 2024/03/06.
//

import UIKit

import DesignSystem
import ResourceKit
import UtilityKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class ProfileEditView: UIView {
	// MARK: Metric
	private enum Metric {
		static let profileImageSize: CGSize = .init(width: 108.0, height: 108.0)
		static let profileImageRadius: CGFloat = profileImageSize.height / 2.0
		static let profileImageViewTopMargin: CGFloat = 24.0
		static let editProfileImageButtonTopMargin: CGFloat = 16.0
	}
	
	// MARK: - TextSet
	private enum TextSet {
		static let navigationTitle: String = "내 정보"
		static let editProfileImageButtonTitle: String = "프로필 사진 바꾸기"
	}
  // MARK: - UI Property
	private let navigationBar: NavigationBar = .init(
		.back,
		title: TextSet.navigationTitle
	)
	private let profileImageView: UIImageView = UIImageView().then {
		$0.makeCornerRadiusWithBorder(
			Metric.profileImageRadius,
			borderColor: AppTheme.Color.background
		)
		$0.backgroundColor = AppTheme.Color.primary
	}
	
	private let editProfileImageButton: UIButton = UIButton(type: .system).then {
		$0.setTitle(TextSet.editProfileImageButtonTitle, for: .normal)
		$0.titleLabel?.font = AppTheme.Font.Medium_14
		$0.tintColor = AppTheme.Color.primary
	}
  // MARK: - Property
  
  // MARK: - Initialize
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConfigures()
    setupViews()
    setupBinds()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public Method
}

// MARK: - Viewable
extension ProfileEditView: Viewable {
  func setupConfigures() {
		backgroundColor = AppTheme.Color.white
  }
  
  func setupViews() {
		addSubview(navigationBar)
		addSubview(profileImageView)
		addSubview(editProfileImageButton)
    setupConstraints()
  }
  
  func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		profileImageView.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.profileImageViewTopMargin)
			make.centerX.equalToSuperview()
			make.size.equalTo(Metric.profileImageSize)
		}
		
		editProfileImageButton.snp.makeConstraints { make in
			make.top.equalTo(profileImageView.snp.bottom).offset(Metric.editProfileImageButtonTopMargin)
			make.centerX.equalToSuperview()
		}
  }
  
  func setupBinds() { }
}
