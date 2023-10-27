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
  private struct Metric {
    let buttonSize: CGFloat = 54
    let buttonRadius: CGFloat = 27
  }
  
  // MARK: INPUT PROPERTY
  private let type: SocialLoginType
  
  // MARK: PROPERTY
  private let metric: Metric
  
  // MARK: INITIALIZE
  public init(
    _ type: SocialLoginType
  ) {
    self.type = type
    self.metric = .init()
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
      setImage(.AppImage.naverLogin, for: .normal)
    case .kakao:
      setImage(.AppImage.kakaoLogin, for: .normal)
    case .apple:
      setImage(.AppImage.appleLogin, for: .normal)
    case .email:
      setImage(.AppImage.emailLogin, for: .normal)
    }
    
    makeCornerRadius(metric.buttonRadius)
  }
  
  /// LoginButton의 Frame을 정의합니다.
  func setupFrame() {
    snp.makeConstraints { make in
      make.size.equalTo(metric.buttonSize)
    }
  }
}
