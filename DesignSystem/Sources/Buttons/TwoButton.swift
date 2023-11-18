//
//  TwoButton.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/11/18.
//

import UIKit

import ResourceKit

import RxCocoa
import RxSwift

public final class TwoButton: UIView {
	
	public enum TwoButtonSizeType {
		case equal
		case leftLarger
		case rightLarger
	}
	
	public enum ButtonType {
		case primary
		case origin
	}
	
	// MARK: - METRIC
	private enum Metric {
		static let spacing: CGFloat = 16
		static let height: CGFloat = 48
		static let smallButtonWidth: CGFloat = 94
		
		static let buttonRadius: CGFloat = 12
	}
	
	// MARK: - TAP ACTION CLOSURE
	fileprivate var didTapLeftButton: PublishSubject<Void> = .init()
	fileprivate var didTapRightButton: PublishSubject<Void> = .init()
	
	// MARK: - CONFIGURE PROPERTY
	private let sizeType: TwoButtonSizeType
	private let buttonType: (left: ButtonType, right: ButtonType)
	private let leftButtonTitle: String
	private let rightButtonTitle: String
	
	private let disposeBag: DisposeBag
	
	// MARK: - UI PROPERTY
	private let leftButton: UIButton = UIButton(type: .system)
	private let rightButton: UIButton = UIButton(type: .system)
	
	private lazy var buttonStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			leftButton,
			rightButton
		]
	).then {
		$0.axis = .horizontal
		$0.distribution = .fillEqually
		$0.spacing = Metric.spacing
	}
	
	public init(
		sizeType: TwoButtonSizeType = .equal,
		buttonType: (left: ButtonType, right: ButtonType) = (left: .origin, right: .primary),
		leftButtonTitle: String,
		rightButtonTitle: String
	) {
		self.sizeType = sizeType
		self.buttonType = buttonType
		self.leftButtonTitle = leftButtonTitle
		self.rightButtonTitle = rightButtonTitle
		self.disposeBag = .init()
		super.init(frame: .zero)
		setupViewConfigure()
		setupViews()
		setupGestures()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - PRIVATE EXTENSION
private extension TwoButton {
	func setupViewConfigure() {
		// MARK: LEFT BUTTON
		let leftButtonType = buttonType.left
		switch leftButtonType {
		case .origin:
			leftButton.backgroundColor = AppTheme.Color.white
			leftButton.makeCornerRadiusWithBorder(Metric.buttonRadius)
			leftButton.setTitle(leftButtonTitle, for: .normal)
			leftButton.tintColor = AppTheme.Color.grey40
			leftButton.titleLabel?.font = AppTheme.Font.Bold_12
		case .primary:
			leftButton.backgroundColor = AppTheme.Color.primary
			leftButton.makeCornerRadius(Metric.buttonRadius)
			leftButton.setTitle(leftButtonTitle, for: .normal)
			leftButton.tintColor = AppTheme.Color.white
			leftButton.titleLabel?.font = AppTheme.Font.Bold_16
		}
		
		// MARK: RIGHT BUTTON
		let rightButtonType = buttonType.right
		switch rightButtonType {
		case .origin:
			rightButton.backgroundColor = AppTheme.Color.white
			rightButton.makeCornerRadiusWithBorder(Metric.buttonRadius)
			rightButton.setTitle(rightButtonTitle, for: .normal)
			rightButton.tintColor = AppTheme.Color.grey40
			rightButton.titleLabel?.font = AppTheme.Font.Bold_12
		case .primary:
			rightButton.backgroundColor = AppTheme.Color.primary
			rightButton.makeCornerRadius(Metric.buttonRadius)
			rightButton.setTitle(rightButtonTitle, for: .normal)
			rightButton.tintColor = AppTheme.Color.white
			rightButton.titleLabel?.font = AppTheme.Font.Bold_16
		}
	}
	
	func setupViews() {
		switch sizeType {
		case .equal:
			addSubview(buttonStackView)
		case .leftLarger, .rightLarger:
			addSubview(leftButton)
			addSubview(rightButton)
		}
		
		setupConstraints()
	}
	
	func setupConstraints() {
		snp.makeConstraints { make in
			make.height.equalTo(Metric.height)
		}
		
		switch sizeType {
		case .equal:
			buttonStackView.snp.makeConstraints { make in
				make.edges.equalToSuperview()
			}
		case .leftLarger:
			leftButton.snp.makeConstraints { make in
				make.verticalEdges.equalToSuperview()
				make.leading.equalToSuperview()
			}
			
			rightButton.snp.makeConstraints { make in
				make.verticalEdges.equalToSuperview()
				make.leading.equalTo(leftButton.snp.trailing).offset(Metric.spacing)
				make.trailing.equalToSuperview()
				make.width.equalTo(Metric.smallButtonWidth)
			}
		case .rightLarger:
			leftButton.snp.makeConstraints { make in
				make.verticalEdges.equalToSuperview()
				make.leading.equalToSuperview()
				make.width.equalTo(Metric.smallButtonWidth)
			}
			
			rightButton.snp.makeConstraints { make in
				make.verticalEdges.equalToSuperview()
				make.leading.equalTo(leftButton.snp.trailing).offset(Metric.spacing)
				make.trailing.equalToSuperview()
			}
		}
	}
	
	func setupGestures() {
		leftButton.rx.touchHandler()
			.bind(to: didTapLeftButton)
			.disposed(by: disposeBag)
		
		rightButton.rx.touchHandler()
			.bind(to: didTapRightButton)
			.disposed(by: disposeBag)
	}
}

extension Reactive where Base: TwoButton {
	public var tapLeftButton: ControlEvent<Void> {
		ControlEvent(events: base.didTapLeftButton.asObservable())
	}
	
	public var tapRightButton: ControlEvent<Void> {
		ControlEvent(events: base.didTapRightButton.asObservable())
	}
}