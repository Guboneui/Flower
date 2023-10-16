//
//  LoginViewController.swift
//  Login
//
//  Created by 구본의 on 2023/10/17.
//

import UIKit

import Then
import SnapKit

public class LoginViewController: UIViewController {
  
  private let titleLabel: UILabel = UILabel().then {
    $0.text = "LOGIN MAIN"
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupSubViews()
  }
  
  private func setupViews() {
    view.backgroundColor = .systemGray
  }
  
  private func setupSubViews() {
    view.addSubview(titleLabel)
    
    setupLayouts()
  }
  
  private func setupLayouts() {
    titleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}
