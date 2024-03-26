//
//  IconTextField.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/11/29.
//

import UIKit

import ResourceKit

import RxCocoa
import RxSwift
import SnapKit
import Then

public class IconTextField: UIView {
	
	// MARK: OUTPUT PROPERTY
	public let currentText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
	
	// MARK: METRIC
	/// IconTextField의 크기 요소를 정의합니다.
	private enum Metric {
		static let iconImageLeftMargin: CGFloat = 16
		static let iconImageVerticalMargin: CGFloat = 16
		
		static let textFieldLeftMargin: CGFloat = 8
		static let textFieldRightMargin: CGFloat = -16
		
		static let clearButtonSize = 20
		static let clearButtonRightMargin = -16
		
		static let height: CGFloat = 50
		static let cornerRadius: CGFloat = 12
		static let iconSize: CGSize = .init(width: 18, height: 18)
	}
	
	// MARK: Font
	private enum Font {
		static let textFieldFont: UIFont = AppTheme.Font.Regular_12
	}
	
	// MARK: ColorSet
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.neutral100
		static let textFieldColor: UIColor = AppTheme.Color.neutral900
	}
	
	// MARK: INPUT PROPERTY
	private let icon: UIImage
	private let placeHolder: String?
	private let keyboardType: UIKeyboardType
	
	// MARK: PROPERTY
	private let disposeBag: DisposeBag
	
	// MARK: UI PROPERTY
	private let iconImageView: UIImageView = UIImageView()
	private let textField: UITextField = UITextField()
	private let clearButton: UIButton = UIButton().then {
		$0.setImage(AppTheme.Image.delete, for: .normal)
		$0.tintColor = AppTheme.Color.neutral100
	}
	
	// MARK: INITIALIZE
	public init(
		icon: UIImage,
		placeHolder: String? = nil,
		keyboardType: UIKeyboardType = .default
	) {
		self.icon = icon
		self.placeHolder = placeHolder
		self.keyboardType = keyboardType
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
	
	/// IconTextField의 text값을 업데이트 합니다.
	public func updateText(text: String) {
		self.textField.text = text
		self.currentText.accept(text)
	}
}

// MARK: - PRIVATE METHOD
private extension IconTextField {
	
	/// IconTextField의 SubView들을 관리합니다
	func setupSubViews() {
		addSubview(iconImageView)
		addSubview(textField)
		addSubview(clearButton)
		
		setupConstrains()
	}
	
	/// IconTextField의 SubView의 오토레이아웃을 정의합니다.
	func setupConstrains() {
		snp.makeConstraints { make in
			make.height.equalTo(Metric.height)
		}
		
		iconImageView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(Metric.iconImageLeftMargin)
			make.verticalEdges.equalToSuperview().inset(Metric.iconImageVerticalMargin)
			make.size.equalTo(Metric.iconSize)
		}
		
		clearButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(Metric.clearButtonRightMargin)
			make.centerY.equalToSuperview()
			make.size.equalTo(Metric.clearButtonSize)
		}
		
		textField.snp.makeConstraints { make in
			make.leading.equalTo(iconImageView.snp.trailing).offset(Metric.textFieldLeftMargin)
			make.trailing.equalTo(clearButton.snp.leading).offset(Metric.textFieldRightMargin)
			make.centerY.equalTo(iconImageView.snp.centerY)
		}
	}
	
	/// IconTextField의 타입에 따른 이미지를 정의합니다.
	func setupConfiguration() {
		backgroundColor = ColorSet.backgroundColor
		makeCornerRadius(Metric.cornerRadius)
		
		iconImageView.image = icon
		iconImageView.tintColor = AppTheme.Color.neutral900
		
		textField.keyboardType = keyboardType
		textField.placeholder = placeHolder
		textField.textColor = ColorSet.textFieldColor
		textField.tintColor = ColorSet.textFieldColor
		textField.font = Font.textFieldFont
	}
	
	func setupBindings() {
		textField.rx.text
			.map { $0 ?? "" }
			.asDriver(onErrorJustReturn: "")
			.drive(onNext: { [weak self] text in
				self?.currentText.accept(text)
			}).disposed(by: disposeBag)
		
		currentText
			.map { $0.isEmpty }
			.asDriver(onErrorJustReturn: true)
			.drive(onNext: { [weak self] isEmpty in
				self?.clearButton.isHidden = isEmpty
			}).disposed(by: disposeBag)
	}
	
	func setupGeustures() {
		clearButton.rx.touchHandler()
			.bind { [weak self] in
				self?.textField.text = ""
				self?.currentText.accept("")
			}.disposed(by: disposeBag)
	}
}
