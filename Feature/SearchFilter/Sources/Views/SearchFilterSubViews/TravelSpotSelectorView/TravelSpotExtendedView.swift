//
//  TravelSpotExtendedView.swift
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

final class TravelSpotExtendedView: UIView {
	
	// MARK: - METRIC
	private enum Metric {
		static let radius: CGFloat = 12
		
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
	
	private enum TextSet {
		static let titleLabelText: String = "게스트하우스 위치를 알려주세요"
		static let searchLabelText: String = "위치 검색"
		static let popularSearchLabelText: String = "인기 검색어"
	}
	
	// MARK: - UI PROPERTY
	private let titleLabel: UILabel = UILabel().then {
		$0.text = TextSet.titleLabelText
		$0.font = AppTheme.Font.Bold_20
		$0.textColor = AppTheme.Color.black
	}
	
	private let locationSearchContainerButton: UIButton = UIButton().then {
		$0.backgroundColor = AppTheme.Color.grey90
		$0.makeCornerRadius(Metric.radius)
	}
	
	private let searchImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.search
		$0.tintColor = AppTheme.Color.black
	}
	
	private let searchLabel: UILabel = UILabel().then {
		$0.text = TextSet.searchLabelText
		$0.font = AppTheme.Font.Regular_12
		$0.textColor = AppTheme.Color.black
	}
	
	private let popularSearchLabel: UILabel = UILabel().then {
		$0.text = TextSet.popularSearchLabelText
		$0.font = AppTheme.Font.Regular_12
		$0.textColor = AppTheme.Color.black
	}
	
	private let popularSpotCollectionView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.grey40
	}
	
	private lazy var stackView: UIStackView = UIStackView(
		arrangedSubviews: [
			titleLabel,
			locationSearchContainerButton,
			popularSearchLabel
		]).then {
			$0.axis = .vertical
			$0.spacing = Metric.stackViewSpacing
		}
	
	private let disposeBag: DisposeBag = .init()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigure()
		setupSubViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - PRIVATE METHOD
private extension TravelSpotExtendedView {
	func setupConfigure() {
		backgroundColor = AppTheme.Color.white
	}
	
	func setupSubViews() {
		addSubview(stackView)
		locationSearchContainerButton.addSubview(searchImageView)
		locationSearchContainerButton.addSubview(searchLabel)
		addSubview(popularSpotCollectionView)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		stackView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.stackViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.subViewHorizontalMargin)
		}
		
		locationSearchContainerButton.snp.makeConstraints { make in
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
}
