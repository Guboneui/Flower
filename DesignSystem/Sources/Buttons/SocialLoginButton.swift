//
//  LoginButton.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/21.
//

import UIKit

import ResourceKit

import SnapKit
import Then

public class SocialLoginButton: UIButton {
  
  // MARK: TYPE
  public enum SocialLoginType {
    case naver
    case kakao
    case apple
    case email
  }
  
  // MARK: METRIC
  /// LoginButton의 크기 요소를 정의합니다.
  private enum Metric {
    static let buttonSize: CGFloat = 54
    static let buttonRadius: CGFloat = 27
  }
  
  // MARK: INPUT PROPERTY
  private let type: SocialLoginType
  
  // MARK: INITIALIZE
  public init(
    _ type: SocialLoginType
  ) {
    self.type = type
    super.init(frame: .zero)
    self.setupConfiguration()
    self.setupFrame()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - PRIVATE METHOD
private extension SocialLoginButton {
  
  /// LoginButton의 타입에 따른 이미지를 정의합니다.
  func setupConfiguration() {
    switch type {
    case .naver:
			setImage(AppTheme.Image.naverLogin, for: .normal)
    case .kakao:
			setImage(AppTheme.Image.kakaoLogin, for: .normal)
    case .apple:
			setImage(AppTheme.Image.appleLogin, for: .normal)
    case .email:
			setImage(AppTheme.Image.emailLogin, for: .normal)
    }
    
    makeCornerRadius(Metric.buttonRadius)
  }
  
  /// LoginButton의 Frame을 정의합니다.
  func setupFrame() {
    snp.makeConstraints { make in
      make.size.equalTo(Metric.buttonSize)
    }
  }
}
