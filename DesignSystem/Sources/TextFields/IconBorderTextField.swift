//
//  IconBorderTextField.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/21.
//

import UIKit

import ResourceKit

import RxCocoa
import RxSwift
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
				return AppTheme.Image.email
      case .password:
				return AppTheme.Image.password
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
  private enum Metric {
   static let iconImageLeftMargin = 16
   static let iconImageTopMargin = 13
   static let iconImageBottomMargin = -15
   
   static let textFieldLeftMargin = 8
   static let textFieldRightMargin = -16
   
   static let height = 46
   static let cornerRadius = 16.0
   static let iconSize = 18
  }
	
	// MARK: Font
	private enum Font {
		static let textFieldFont: UIFont = AppTheme.Font.Regular_12
	}
	
	// MARK: ColorSet
	private enum ColorSet {
		static let textFieldColor: UIColor = AppTheme.Color.neutral900
	}
  
  // MARK: INPUT PROPERTY
  private let type: IconBorderTextFieldType
  private let keyboardType: UIKeyboardType
  
  // MARK: PROPERTY
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
      make.height.equalTo(Metric.height)
    }
    
    iconImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(Metric.iconImageLeftMargin)
      make.top.equalToSuperview().offset(Metric.iconImageTopMargin)
      make.bottom.equalToSuperview().offset(Metric.iconImageBottomMargin)
      make.size.equalTo(Metric.iconSize)
    }
    
    textField.snp.makeConstraints { make in
      make.leading.equalTo(iconImageView.snp.trailing).offset(Metric.textFieldLeftMargin)
      make.trailing.equalToSuperview().offset(Metric.textFieldRightMargin)
      make.centerY.equalTo(iconImageView.snp.centerY)
    }
  }
  
  /// IconBorderTextField의 타입에 따른 이미지를 정의합니다.
  func setupConfiguration() {
    makeCornerRadiusWithBorder(Metric.cornerRadius)
    
    iconImageView.image = type.iconImage
    
    textField.keyboardType = keyboardType
    textField.placeholder = type.placeHolder
		textField.textColor = ColorSet.textFieldColor
		textField.tintColor = ColorSet.textFieldColor
		textField.font = Font.textFieldFont
    textField.isSecureTextEntry = type.security
  }
  
  func setupBindings() {
    textField.rx.text
      .map { $0 ?? "" }
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] text in
        self?.currentText.accept(text)
        self?.iconImageView.tintColor = text.isEmpty ? AppTheme.Color.neutral100 : AppTheme.Color.neutral900
      }).disposed(by: disposeBag)
  }
}
