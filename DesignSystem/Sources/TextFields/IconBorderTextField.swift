//
//  IconBorderTextField.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/21.
//

import UIKit

import ResourceKit

import RxSwift
import RxCocoa
import SnapKit
import Then

public class IconBorderTextField: UIView {
  
  // MARK: OUTPUT PROPERTY
  public let currentText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
  
  // MARK: TYPE
  /// IconBorderTextField에 적용할 타입입니다.
  public enum IconBorderTextFieldType {
    case email
    case password
    
    fileprivate var placeHolder: String {
      switch self {
      case .email:
        return "이메일"
      case .password:
        return "비밀번호"
      }
    }
    
    fileprivate var iconImage: UIImage {
      switch self {
      case .email:
        return .AppImage.email
      case .password:
        return .AppImage.password
      }
    }
    
    fileprivate var security: Bool {
      switch self {
      case .email:
        return false
      case .password:
        return true
      }
    }
  }
  
  // MARK: METRIC
  /// IconBorderTextField의 크기 요소를 정의합니다.
  private struct Metric {
    let iconImageLeftMargin = 16
    let iconImageTopMargin = 13
    let iconImageBottomMargin = -15
    
    let textFieldLeftMargin = 8
    let textFieldRightMargin = -16
    
    let height = 46
    let cornerRadius = 16.0
    let iconSize = 18
  }
  
  // MARK: INPUT PROPERTY
  private let type: IconBorderTextFieldType
  private let keyboardType: UIKeyboardType
  
  // MARK: PROPERTY
  private let textFieldFont: UIFont
  private let textFieldColor: UIColor
  private let metric: Metric
  private let disposeBag: DisposeBag
  
  // MARK: UI PROPERTY
  private let iconImageView: UIImageView = UIImageView()
  private let textField: UITextField = UITextField()
  
  // MARK: INITIALIZE
  public init(
    _ type: IconBorderTextFieldType,
    keyboardType: UIKeyboardType = .default
  ) {
    self.type = type
    self.keyboardType = keyboardType
    self.textFieldFont = .AppFont.Regular_12
    self.textFieldColor = .AppColor.appBlack
    self.metric = .init()
    self.disposeBag = .init()
    super.init(frame: .zero)
    self.setupSubViews()
    self.setupConfiguration()
    self.setupBindings()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// IconBorderTextField의 text값을 업데이트 합니다.
  public func updateText(text: String) {
    self.textField.text = text
    self.currentText.accept(text)
  }
}

// MARK: - PRIVATE METHOD
private extension IconBorderTextField {
  
  /// IconBorderTextField의 SubView들을 관리합니다
  func setupSubViews() {
    addSubview(iconImageView)
    addSubview(textField)
    
    setupConstrains()
  }
  
  /// IconBorderTextField의 SubView의 오토레이아웃을 정의합니다.
  func setupConstrains() {
    snp.makeConstraints { make in
      make.height.equalTo(metric.height)
    }
    
    iconImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(metric.iconImageLeftMargin)
      make.top.equalToSuperview().offset(metric.iconImageTopMargin)
      make.bottom.equalToSuperview().offset(metric.iconImageBottomMargin)
      make.size.equalTo(metric.iconSize)
    }
    
    textField.snp.makeConstraints { make in
      make.leading.equalTo(iconImageView.snp.trailing).offset(metric.textFieldLeftMargin)
      make.trailing.equalToSuperview().offset(metric.textFieldRightMargin)
      make.centerY.equalTo(iconImageView.snp.centerY)
    }
  }
  
  /// IconBorderTextField의 타입에 따른 이미지를 정의합니다.
  func setupConfiguration() {
    makeCornerRadiusWithBorder(16)
    
    iconImageView.image = type.iconImage
    
    textField.keyboardType = keyboardType
    textField.placeholder = type.placeHolder
    textField.textColor = textFieldColor
    textField.tintColor = textFieldColor
    textField.font = textFieldFont
    textField.isSecureTextEntry = type.security
  }
  
  /// IconBorderTextField의 CornerRadius 및 Border를 정의합니다.
  func setupCornerRadiusWithBorder() {
    makeCorderRadius(metric.cornerRadius)
    layer.borderColor = UIColor.AppColor.appGrey70.cgColor
    layer.borderWidth = 1
  }
  
  func setupBindings() {
    textField.rx.text
      .map{ $0 ?? "" }
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] text in
        self?.currentText.accept(text)
        self?.iconImageView.tintColor = text.isEmpty ? .AppColor.appGrey70 : .AppColor.appBlack
      }).disposed(by: disposeBag)
  }
}
