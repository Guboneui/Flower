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
  private enum Metric {
    static let buttonHeight: CGFloat = 48
    static let buttonRadius: CGFloat = 16
  }
	
	// MARK: Font
	private enum Font {
		static let buttonFont: UIFont = AppTheme.Font.Bold_14
	}
  
  // MARK: COLORSET
  /// DefaultButton의 색상 요소를 정의합니다.
  private enum ColorSet {
		static let enableTitleColor: UIColor = AppTheme.Color.white
		static let enableBackgroundColor: UIColor = AppTheme.Color.primary
		static let disableTitleColor: UIColor = AppTheme.Color.neutral100
    static let disableBackgroundColor: UIColor = AppTheme.Color.neutral300
		static let pressedColor: UIColor = AppTheme.Color.primary.withAlphaComponent(0.75)
  }
  
  // MARK: INPUT PROPERTY
  private let title: String
  private let initEnableState: Bool
  
  // MARK: PROPERTY
  private let disposeBag: DisposeBag
  
  // MARK: INITIALIZE
  public init(
    title: String,
    initEnableState: Bool = true
  ) {
    self.title = title
    self.disposeBag = .init()
    self.initEnableState = initEnableState
    super.init(frame: .zero)
    self.isEnabled = initEnableState
    self.setupConfiguration()
    self.setupFrame()
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
		titleLabel?.font = Font.buttonFont
    
    makeCornerRadius(Metric.buttonRadius)
    
		if isEnabled {
			setupEnableButtonState()
		} else {
			setupDisableButtonState()
		}
  }
  
  /// DefatulButton의 고정 높이를 지정합니다.
  func setupFrame() {
    snp.makeConstraints { make in
      make.height.equalTo(Metric.buttonHeight)
    }
  }
  
  /// DefatulButton의 'isEnable = true'의 상태를 정의합니다.
  func setupEnableButtonState() {
    backgroundColor = ColorSet.enableBackgroundColor
    setTitleColor(ColorSet.enableTitleColor, for: .normal)
  }
  
  /// DefatulButton의 'isEnable = false'의 상태를 정의합니다.
  func setupDisableButtonState() {
    backgroundColor = ColorSet.disableBackgroundColor
    setTitleColor(ColorSet.disableTitleColor, for: .disabled)
  }
  
  /// DefatulButton의 'isHighlighted = true'의 상태를 정의합니다.
  func setupStartPressingButton() {
    backgroundColor = ColorSet.pressedColor
  }
  
  /// DefatulButton의 'isHighlighted = false'의 상태를 정의합니다.
  func setupEndPressingButton() {
    backgroundColor = ColorSet.enableBackgroundColor
  }
}
