//
//  TravelSpotSelectorView.swift
//  SearchFilter
//
//  Created by 구본의 on 2023/11/19.
//

import UIKit

import DesignSystem
import ResourceKit

import RxRelay
import RxSwift
import SnapKit
import Then

final class TravelSpotSelectorView: UIView {
	
	// MARK: - METRIC
	private enum Metric {
		static let radius: CGFloat = 22
		static let stackViewSpacing: CGFloat = 24
		static let stackViewTopMargin: CGFloat = 24
		static let stackViewHorizontalMargin: CGFloat = 24
		
		static let subViewHorizontalMargin: CGFloat = 24
		static let locationContainerViewHeight: CGFloat = 50
		static let searchImageSize: CGFloat = 18
		static let searchLabelLeftMargin: CGFloat = 8
		
		static let popularSpotCollectionViewTopMargin: CGFloat = 8
		static let popularSpotCollectionViewBottomMargin: CGFloat = -30
		static let popularSpotCollectionViewHeight: CGFloat = 56
	}
	
	// MARK: - UI PROPERTY
	private let titleLabel: UILabel = UILabel().then {
		$0.text = "게스트하우스 위치를 알려주세요"
		$0.font = AppTheme.Font.Bold_20
		$0.textColor = AppTheme.Color.black
	}
	
	private let locationSearchContainerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.grey90
		$0.makeCornerRadius(12)
	}
	
	private let searchImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.search
		$0.tintColor = AppTheme.Color.black
	}
	
	private let searchLabel: UILabel = UILabel().then {
		$0.text = "위치 검색"
		$0.font = AppTheme.Font.Regular_12
		$0.textColor = AppTheme.Color.black
	}
	
	private let popularSearchLabel: UILabel = UILabel().then {
		$0.text = "인기 검색어"
		$0.font = AppTheme.Font.Regular_12
		$0.textColor = AppTheme.Color.black
	}
	
	private let popularSpotCollectionView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.grey40
	}
	
	private lazy var stackView: UIStackView = UIStackView(
		arrangedSubviews: [
			titleLabel,
			locationSearchContainerView,
			popularSearchLabel
		]).then {
			$0.axis = .vertical
			$0.spacing = Metric.stackViewSpacing
		}
	
	private let locationLabel: UILabel = UILabel().then {
		$0.text = "위치"
		$0.font = AppTheme.Font.Regular_12
		$0.textColor = AppTheme.Color.black
	}
	
	private let selectedLocationLabel: UILabel = UILabel().then {
		$0.text = "제주특별자치도 서귀포시"
		$0.font = AppTheme.Font.Regular_12
		$0.textColor = AppTheme.Color.black
		$0.textAlignment = .right
	}
	
	public var currentState: BehaviorRelay<Bool> = .init(value: true)
	private let disposeBag: DisposeBag = .init()
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigure()
		setupBindings()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func setExtendableState() {
		
		subviews.forEach {
//			$0.alpha = 0.0
			$0.removeFromSuperview()
		}
//		
		addSubview(stackView)
		locationSearchContainerView.addSubview(searchImageView)
		locationSearchContainerView.addSubview(searchLabel)
		addSubview(popularSpotCollectionView)
		
		stackView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.stackViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.subViewHorizontalMargin)
		}
		
		locationSearchContainerView.snp.makeConstraints { make in
			make.height.equalTo(Metric.locationContainerViewHeight)
		}
		
		searchImageView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(Metric.subViewHorizontalMargin)
			make.centerY.equalToSuperview()
			make.size.equalTo(Metric.searchImageSize)
		}
		
		searchLabel.snp.makeConstraints { make in
			make.leading.equalTo(self.searchImageView.snp.trailing).offset(Metric.searchLabelLeftMargin)
			make.trailing.equalToSuperview().offset(-Metric.subViewHorizontalMargin)
			make.centerY.equalToSuperview()
		}
		
		popularSpotCollectionView.snp.makeConstraints { make in
			make.top.equalTo(self.stackView.snp.bottom).offset(Metric.popularSpotCollectionViewTopMargin)
			make.bottom.equalToSuperview().offset(Metric.popularSpotCollectionViewBottomMargin)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(Metric.popularSpotCollectionViewHeight)
		}
		
	}
	
	public func setTestState() {
		
		subviews.forEach {
			$0.removeFromSuperview()
		}
		
		addSubview(locationLabel)
		locationLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		addSubview(selectedLocationLabel)
		
		
		self.locationLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(32)
			make.verticalEdges.equalToSuperview().inset(24)
		}
		
		self.selectedLocationLabel.snp.makeConstraints { make in
			make.leading.equalTo(self.locationLabel.snp.trailing).offset(8)
			make.trailing.equalToSuperview().offset(-32)
			make.centerY.equalToSuperview()
		}
		
	}
}

// MARK: - PRIVATE METHOD
private extension TravelSpotSelectorView {
	func setupConfigure() {
		backgroundColor = AppTheme.Color.white
		makeCornerRadiusWithBorder(Metric.radius)
		
		self.layer.masksToBounds = false
		self.layer.shadowColor = AppTheme.Color.black.withAlphaComponent(0.1).cgColor
		self.layer.shadowOpacity = 1.0
		self.layer.shadowRadius = 20
		self.layer.shadowOffset = .init(width: 0, height: 2)
	}
	
	func setupBindings() {
		currentState.asDriver()
			.drive { [weak self] state in
				guard let self else { return }
				if state {
					self.setExtendableState()
				} else {
					self.setTestState()
				}
			}.disposed(by: disposeBag)
	}
}
