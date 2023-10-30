//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/31.
//

import UIKit

import ResourceKit

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
				return .AppImage.arrowLeft
			case .close:
				return .AppImage.xmark
			case .none:
				return nil
			}
		}
	}
	
	// MARK: METRIC
	private struct Metric {
		let navigationBarHeight: CGFloat = 50
		
		let leftButtonSize: CGSize = .init(width: 30, height: 30)
		let leftButtonLeftMargin: CGFloat = 20
		
		let navigationTitleTopMargin: CGFloat = 14
		let navigationTitleBottomMargin: CGFloat = -15
	}
	
	// MARK: - OUTPUT
	public var didTapLeftButton: (() -> Void)?
	
	// MARK: - PROPERTY
	private let navigationType: NavigationType
	private let navigationTitle: String
	private let navigationLeftButtonColor: UIColor
	private let navigationTitleFont: UIFont
	private let navigationTitleColor: UIColor
	private let metric: Metric
	private let disposeBag: DisposeBag
	
	private let navigationLeftButton: UIButton = UIButton(type: .system)
	private let navigationTitleLabel: UILabel = UILabel()
	
	// MARK: - Initialize
	public init(
		_ navigationType: NavigationType = .none,
		title: String = ""
	) {
		self.navigationType = navigationType
		self.navigationTitle = title
		self.navigationLeftButtonColor = .AppColor.appBlack
		self.navigationTitleFont = .AppFont.Bold_18
		self.navigationTitleColor = .AppColor.appBlack
		self.metric = .init()
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
		backgroundColor = .white
		
		navigationLeftButton.setImage(navigationType.buttonImage, for: .normal)
		navigationLeftButton.tintColor = navigationLeftButtonColor
		
		navigationTitleLabel.text = navigationTitle
		navigationTitleLabel.font = navigationTitleFont
		navigationTitleLabel.textColor = navigationTitleColor
	}
	
	func setupSubViews() {
		addSubview(navigationLeftButton)
		addSubview(navigationTitleLabel)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		snp.makeConstraints { make in
			make.height.equalTo(metric.navigationBarHeight)
		}
		
		navigationLeftButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(metric.leftButtonLeftMargin)
			make.centerY.equalToSuperview()
			make.size.equalTo(navigationType == .none ? 0 : metric.leftButtonSize)
		}
		
		navigationTitleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(metric.navigationTitleTopMargin)
			make.bottom.equalToSuperview().offset(metric.navigationTitleBottomMargin)
			make.centerX.equalToSuperview()
		}
	}
	
	func setupGestures() {
		navigationLeftButton.rx.tap
			.throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
			.bind { [weak self] in
				guard let self else { return }
				switch navigationType {
				case .back, .close:
					didTapLeftButton?()
				case .none:
					break
				}
			}.disposed(by: disposeBag)
	}
}
