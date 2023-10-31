//
//  LoginViewController.swift
//  Login
//
//  Created by 구본의 on 2023/10/17.
//

import UIKit

import DesignSystem
import ResourceKit

import SnapKit
import Then

public final class LoginViewController: UIViewController {

  private let logoView: UIView = UIView().then {
    $0.backgroundColor = .lightGray
  }
  
  private let loginLabel: UILabel = UILabel().then {
    $0.text = "로그인/회원가입"
    $0.font = .AppFont.Regular_14
    $0.textColor = .AppColor.appBlack
  }
  
  private let loginStackView: UIStackView = UIStackView().then {
    $0.distribution = .equalSpacing
  }
  
  private let naverLoginButton: SocialLoginButton = SocialLoginButton(.naver)
  private let kakaoLoginButton: SocialLoginButton = SocialLoginButton(.kakao)
  private let appleLoginButton: SocialLoginButton = SocialLoginButton(.apple)
  private let emailLoginButton: SocialLoginButton = SocialLoginButton(.email)
  
  private enum Metric {
    static let loginStackViewTop = 28
    static let loginStackViewInset = 52
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupSubViews()
  }

  private func setupViews() {
    view.backgroundColor = .white
  }

  private func setupSubViews() {
    view.addSubview(logoView)
    view.addSubview(loginLabel)
    view.addSubview(loginStackView)
    
    loginStackView.addArrangedSubview(naverLoginButton)
    loginStackView.addArrangedSubview(kakaoLoginButton)
    loginStackView.addArrangedSubview(appleLoginButton)
    loginStackView.addArrangedSubview(emailLoginButton)

    setupLayouts()
  }

  private func setupLayouts() {
    loginLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    // MARK: TODO 민희
    logoView.snp.makeConstraints { make in
      make.size.equalTo(100)
      make.height.width.equalTo(100)
      make.centerX.equalToSuperview()
      make.bottom.equalTo(loginLabel.snp.top).offset(-38)
    }
    
    loginStackView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.horizontalEdges.equalToSuperview().inset(Metric.loginStackViewInset)
      make.top.equalTo(loginLabel.snp.bottom).offset(Metric.loginStackViewTop)
    }
  }
}
