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
    
    private let mainLogoView: UIView = UIView().then {
        $0.backgroundColor = .AppColor.appGrey70
    }
    
    private let loginLabel: UILabel = UILabel().then {
        $0.text = "로그인/회원가입"
        $0.font = .AppFont.Regular_14
        $0.textColor = .AppColor.appBlack
        $0.textAlignment = .center
    }
    
    private let socialLoginsStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 24
    }
    
    private let naverLoginButton: SocialLoginButton = SocialLoginButton(.naver)
    private let appleLoginButton: SocialLoginButton = SocialLoginButton(.apple)
    private let kakaoLoginButton: SocialLoginButton = SocialLoginButton(.kakao)
    private let emailLoginButton: SocialLoginButton = SocialLoginButton(.email)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(mainLogoView)
        view.addSubview(loginLabel)
        
        view.addSubview(socialLoginsStackView)
        
        socialLoginsStackView.addArrangedSubview(naverLoginButton)
        socialLoginsStackView.addArrangedSubview(appleLoginButton)
        socialLoginsStackView.addArrangedSubview(kakaoLoginButton)
        socialLoginsStackView.addArrangedSubview(emailLoginButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainLogoView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalToSuperview().inset(277)
            make.centerX.equalToSuperview()
            
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLogoView.snp.bottom).offset(38)
            make.leading.equalToSuperview().inset(0)
            make.trailing.equalToSuperview().inset(0)
            
        }
        
        socialLoginsStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(28)
            make.bottom.equalToSuperview().inset(338)
            make.leading.equalToSuperview().inset(52)
            make.trailing.equalToSuperview().inset(52)
        }
        
    }
    
}
