//
//  DefaultButton.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/20.
//

import UIKit

import ResourceKit

import RxGesture
import RxSwift
import SnapKit

public class DefaultButton: UIButton {
  
  // MARK: METRIC
  /// DefaultButton의 크기 요소를 정의합니다.
  private struct Metric {
    let buttonHeight: CGFloat = 48
    let buttonRadius: CGFloat = 10
  }
  
  // MARK: COLORSET
  /// DefaultButton의 색상 요소를 정의합니다.
  private struct ColorSet {
    let enableTitleColor: UIColor = .white
    let enableBackgroundColor: UIColor = .AppColor.appPrimary
    let disableTitleColor: UIColor = .white
    let disableBackgroundColor: UIColor = .AppColor.appGrey70
    let pressedColor: UIColor = .AppColor.appPrimary.withAlphaComponent(0.75)
  }
  
  // MARK: INPUT PROPERTY
  private let title: String
  private let initEnableState: Bool
  
  // MARK: PROPERTY
  private let metric: Metric
  private let colorSet: ColorSet
  private let buttonFont: UIFont
  private let disposeBag: DisposeBag
  
  // MARK: INITIALIZE
  public init(
    title: String,
    initEnableState: Bool = true
  ) {
    self.title = title
    self.metric = .init()
    self.colorSet = .init()
    self.buttonFont = .AppFont.Bold_14
    self.disposeBag = .init()
    self.initEnableState = initEnableState
    super.init(frame: .zero)
    self.isEnabled = initEnableState
    self.setupConfiguration()
    self.setupFrame()
    self.setupCornerRadius()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: PROPERTY OBSERVER
  
  /// DefaultButton의 이용 가능 상태에 대해 시각 효과를 제공하기 위함
  public override var isEnabled: Bool {
    didSet {
      isEnabled ? setupEnableButtonState() : setupDisableButtonState()
    }
  }
  
  /// DefaultButton의 눌림 상태에 대해 시각 효과를 제공하기 위함
  public override var isHighlighted: Bool {
    didSet {
      isHighlighted ? setupStartPressingButton() : setupEndPressingButton()
    }
  }
}

// MARK: - PRIVATE METHOD
private extension DefaultButton {
  
  /// DefatulButton의 기본 상태를 정의합니다.
  func setupConfiguration() {
    setTitle(title, for: .normal)
    titleLabel?.font = buttonFont
    if isEnabled { setupEnableButtonState() }
    else { setupDisableButtonState() }
  }
  
  /// DefatulButton의 고정 높이를 지정합니다.
  func setupFrame() {
    snp.makeConstraints { make in
      make.height.equalTo(metric.buttonHeight)
    }
  }
  
  /// DefatulButton의 cornerRadius를 설정합니다.
  func setupCornerRadius() {
    layer.masksToBounds = true
    layer.cornerRadius = metric.buttonRadius
  }
  
  /// DefatulButton의 'isEnable = true'의 상태를 정의합니다.
  func setupEnableButtonState() {
    backgroundColor = colorSet.enableBackgroundColor
    setTitleColor(colorSet.enableTitleColor, for: .normal)
  }
  
  /// DefatulButton의 'isEnable = false'의 상태를 정의합니다.
  func setupDisableButtonState() {
    backgroundColor = colorSet.disableBackgroundColor
    setTitleColor(colorSet.disableTitleColor, for: .disabled)
  }
  
  /// DefatulButton의 'isHighlighted = true'의 상태를 정의합니다.
  func setupStartPressingButton() {
    backgroundColor = colorSet.pressedColor
  }
  
  /// DefatulButton의 'isHighlighted = false'의 상태를 정의합니다.
  func setupEndPressingButton() {
    backgroundColor = colorSet.enableBackgroundColor
  }
}
