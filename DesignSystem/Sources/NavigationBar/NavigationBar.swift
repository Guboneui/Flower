//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/31.
//

import UIKit

import ResourceKit

import RxCocoa
import RxGesture
import RxSwift
import SnapKit
import Then

public class NavigationBar: UIView {
	
	// MARK: - NavigationType
	public enum NavigationType {
		case back
		case close
		case none
		
		fileprivate var buttonImage: UIImage? {
			switch self {
			case .back:
				return AppTheme.Image.arrowLeft
			case .close:
				return AppTheme.Image.xmark
			case .none:
				return nil
			}
		}
	}
	
	// MARK: METRIC
	private enum Metric {
		static let navigationBarHeight: CGFloat = 50

		static let leftButtonSize: CGSize = .init(width: 30, height: 30)
		static let leftButtonLeftMargin: CGFloat = 20
		
		static let navigationTitleTopMargin: CGFloat = 14
		static let navigationTitleBottomMargin: CGFloat = -15
		
		static let guideLineHeight: CGFloat = 1
	}
	
	// MARK: Font
	private enum Font {
		static let navigationTitleFont: UIFont = AppTheme.Font.Bold_18
	}
	
	// MARK: ColorSet
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.white
		static let navigationTitleColor: UIColor = AppTheme.Color.black
		static let navigationLeftButtonColor: UIColor = AppTheme.Color.black
		static let guideLineColor: UIColor = AppTheme.Color.grey70
	}
	
	// MARK: - TAP SUBJECT
	fileprivate var didTapLeftButton: PublishSubject<Void> = .init()
	
	// MARK: - PROPERTY
	private let navigationType: NavigationType
	private let navigationTitle: String
	private let hasGuideLine: Bool
	private let disposeBag: DisposeBag
	
	private let navigationLeftButton: UIButton = UIButton(type: .system)
	private let navigationTitleLabel: UILabel = UILabel()
	private let guideLineView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.guideLineColor
	}
	
	// MARK: - Initialize
	public init(
		_ navigationType: NavigationType = .none,
		title: String = "",
		hasGuideLine: Bool = false
	) {
		self.navigationType = navigationType
		self.navigationTitle = title
		self.hasGuideLine = hasGuideLine
		self.disposeBag = .init()
		super.init(frame: .zero)
		setupConfigure()
		setupSubViews()
		setupGestures()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - PUBLIC METHOD
	public func updateNavigationTitle(_ title: String) {
		navigationTitleLabel.text = title
	}
}

private extension NavigationBar {
	func setupConfigure() {
		backgroundColor = ColorSet.backgroundColor
		
		navigationLeftButton.setImage(navigationType.buttonImage, for: .normal)
		navigationLeftButton.tintColor = ColorSet.navigationLeftButtonColor
		
		navigationTitleLabel.text = navigationTitle
		navigationTitleLabel.font = Font.navigationTitleFont
		navigationTitleLabel.textColor = ColorSet.navigationTitleColor
	}
	
	func setupSubViews() {
		addSubview(navigationLeftButton)
		addSubview(navigationTitleLabel)
		
		if hasGuideLine {
			addSubview(guideLineView)
		}
		
		setupConstraints()
	}
	
	func setupConstraints() {
		snp.makeConstraints { make in
			make.height.equalTo(Metric.navigationBarHeight)
		}
		
		navigationLeftButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(Metric.leftButtonLeftMargin)
			make.centerY.equalToSuperview()
			make.size.equalTo(navigationType == .none ? 0 : Metric.leftButtonSize)
		}
		
		navigationTitleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.navigationTitleTopMargin)
			make.bottom.equalToSuperview().offset(Metric.navigationTitleBottomMargin)
			make.centerX.equalToSuperview()
		}
		
		if hasGuideLine {
			guideLineView.snp.makeConstraints { make in
				make.horizontalEdges.equalToSuperview()
				make.bottom.equalToSuperview()
				make.height.equalTo(Metric.guideLineHeight)
			}
		}
	}
	
	func setupGestures() {
		navigationLeftButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				switch navigationType {
				case .back, .close:
					didTapLeftButton.onNext(())
				case .none:
					break
				}
			}.disposed(by: disposeBag)
	}
}

extension Reactive where Base: NavigationBar {
	public var tapLeftButton: ControlEvent<Void> {
		ControlEvent(events: base.didTapLeftButton.asObservable())
	}
}
