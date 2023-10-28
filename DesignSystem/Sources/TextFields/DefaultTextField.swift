//
//  DefaultTextField.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/22.
//

import UIKit

import ResourceKit

import RxCocoa
import RxSwift
import SnapKit
import Then

public class DefaultTextField: UIView {
  
  // MARK: OUTPUT PROPERTY
  public let currentText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
  
  // MARK: ACTION CLOSURE
  public var didTapTextButton: (() -> Void)?
  
  // MARK: TYPE
  /// DefaultTextField에 적용할 타입입니다.
  public enum DefaultTextFieldType {
    case email
    case password
    case emailAuthCode
    case name
    
    fileprivate var placeHolder: String {
      switch self {
      case .email:
        return "이메일"
      case .password:
        return "비밀번호"
      case .emailAuthCode:
        return "인증번호"
      case .name:
        return "김동겸"
      }
    }
    
    fileprivate var security: Bool {
      switch self {
      case .email, .emailAuthCode, .name:
        return false
      case .password:
        return true
      }
    }
    
    fileprivate var buttonTitle: String {
      switch self {
      case .emailAuthCode:
        return "인증번호 재전송"
      default:
        return ""
      }
    }
  }
  
  // MARK: METRIC
  /// DefaultTextField의 크기 요소를 정의합니다.
  private struct Metric {
    let textFieldLeftMargin = 16
    let textFieldRightMargin = -8
    let textFieldTopMargin = 14
    let textFieldBottomMargin = -15
    
    let clearButtonSize = 16
    let clearButtonRightMargin = -16
    
    let securityButtonSize = 16
    let securitRightMargin = -8
    
    let textButtonVerticalMargin = 17
    let textButtonRightMargin = -16
    
    let height = 46
    let cornerRadius = 16.0
  }
  
  // MARK: INPUT PROPERTY
  private let type: DefaultTextFieldType
  private let keyboardType: UIKeyboardType
  
  // MARK: PROPERTY
  private let baseBackgroundColor: UIColor
  private let textFieldFont: UIFont
  private let textFieldColor: UIColor
  private let metric: Metric
  private let disposeBag: DisposeBag
  
  // MARK: UI PROPERTY
  private let textField: UITextField = UITextField()
  private let clearButton: UIButton = UIButton().then {
    $0.setImage(.AppImage.delete, for: .normal)
    $0.tintColor = .AppColor.appGrey70
  }
  
  private let securityButton: UIButton = UIButton().then {
    $0.setImage(.AppImage.showOff, for: .normal)
    $0.setImage(.AppImage.showOn, for: .selected)
  }
  
  private lazy var textButton: UIButton = UIButton().then {
    $0.setTitle(type.buttonTitle, for: .normal)
    $0.setTitleColor(.AppColor.appBlack, for: .normal)
    $0.titleLabel?.font = .AppFont.Bold_10
  }
  
  // MARK: INITIALIZE
  public init(
    _ type: DefaultTextFieldType,
    keyboardType: UIKeyboardType = .default
  ) {
    self.type = type
    self.keyboardType = keyboardType
    self.baseBackgroundColor = .AppColor.appGrey90
    self.textFieldFont = .AppFont.Regular_12
    self.textFieldColor = .AppColor.appBlack
    self.metric = .init()
    self.disposeBag = .init()
    super.init(frame: .zero)
    self.setupSubViews()
    self.setupConfiguration()
    self.setupBindings()
    self.setupGeustures()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// DefaultTextField의 text값을 업데이트 합니다.
  public func updateText(text: String) {
    self.textField.text = text
    self.currentText.accept(text)
  }
}

// MARK: - PRIVATE METHOD
private extension DefaultTextField {
  
  /// DefaultTextField의 SubView들을 관리합니다
  func setupSubViews() {
    addSubview(textField)
    switch type {
    case .email, .name:
      addSubview(clearButton)
    case .password:
      addSubview(securityButton)
      addSubview(clearButton)
    case .emailAuthCode:
      addSubview(textButton)
    }
    
    setupConstrains()
  }
  
  /// DefaultTextField의 SubView의 오토레이아웃을 정의합니다.
  func setupConstrains() {
    snp.makeConstraints { make in
      make.height.equalTo(metric.height)
    }
    
    switch type {
    case .email, .name:
      clearButton.snp.makeConstraints { make in
        make.trailing.equalToSuperview().offset(metric.clearButtonRightMargin)
        make.centerY.equalToSuperview()
        make.size.equalTo(metric.clearButtonSize)
      }
      
      textField.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(metric.textFieldTopMargin)
        make.leading.equalToSuperview().offset(metric.textFieldLeftMargin)
        make.trailing.equalTo(clearButton.snp.leading).offset(metric.textFieldRightMargin)
        make.bottom.equalToSuperview().offset(metric.textFieldBottomMargin)
      }

    case .password:
      clearButton.snp.makeConstraints { make in
        make.trailing.equalToSuperview().offset(metric.clearButtonRightMargin)
        make.centerY.equalToSuperview()
        make.size.equalTo(metric.clearButtonSize)
      }
      
      securityButton.snp.makeConstraints { make in
        make.trailing.equalTo(clearButton.snp.leading).offset(metric.securitRightMargin)
        make.centerY.equalToSuperview()
        make.size.equalTo(metric.securityButtonSize)
      }
      
      textField.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(metric.textFieldTopMargin)
        make.leading.equalToSuperview().offset(metric.textFieldLeftMargin)
        make.trailing.equalTo(securityButton.snp.leading).offset(metric.textFieldRightMargin)
        make.bottom.equalToSuperview().offset(metric.textFieldBottomMargin)
      }

    case .emailAuthCode:
      textButton.snp.makeConstraints { make in
        make.trailing.equalToSuperview().offset(metric.textButtonRightMargin)
        make.verticalEdges.equalToSuperview().inset(metric.textButtonVerticalMargin)
        make.width.equalTo(textButton.intrinsicContentSize.width)
      }
      
      textField.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(metric.textFieldTopMargin)
        make.leading.equalToSuperview().offset(metric.textFieldLeftMargin)
        make.trailing.equalTo(textButton.snp.leading).offset(metric.textFieldRightMargin)
        make.bottom.equalToSuperview().offset(metric.textFieldBottomMargin)
      }
    }
  }
  
  /// DefaultTextField의 타입에 따른 이미지를 정의합니다.
  func setupConfiguration() {
    makeCornerRadius(16)
    backgroundColor = baseBackgroundColor
    
    textField.keyboardType = keyboardType
    textField.placeholder = type.placeHolder
    textField.textColor = textFieldColor
    textField.tintColor = textFieldColor
    textField.font = textFieldFont
    textField.isSecureTextEntry = type.security
  }
  
  /// DefaultTextField의 Binding을 정의합니다.
  func setupBindings() {
    textField.rx.text
      .map{ $0 ?? "" }
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] text in
        self?.currentText.accept(text)
      }).disposed(by: disposeBag)
  }
  
  /// DefaultTextField의 CornerRadius 및 Gesture를 정의합니다.
  func setupGeustures() {
    clearButton.rx.tap
      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
      .bind { [weak self] in
        self?.textField.text = ""
        self?.currentText.accept("")
      }.disposed(by: disposeBag)
    
    securityButton.rx.tap
      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
      .bind { [weak self] in
        self?.securityButton.isSelected.toggle()
        self?.textField.isSecureTextEntry.toggle()
      }.disposed(by: disposeBag)
    
    textButton.rx.tap
      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
      .bind { [weak self] in
        self?.didTapTextButton?()
      }.disposed(by: disposeBag)
  }
}

