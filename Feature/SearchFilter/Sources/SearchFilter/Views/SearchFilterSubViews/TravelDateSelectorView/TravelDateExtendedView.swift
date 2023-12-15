//
//  TravelDateExtendedView.swift
//  SearchFilter
//
//  Created by 구본의 on 2023/12/06.
//

import UIKit

import DesignSystem
import ResourceKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class TravelDateExtendedView: UIView {
	
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
		static let popularSpotCollectionViewCellSize: CGSize = .init(width: 56, height: 56)
		static let popularSpotCollectionViewSpacing: CGFloat = 6
		static let popularSpotCollectionViewVerticalInset: CGFloat = 0
		static let popularSpotCollectionViewHorizontalInset: CGFloat = 20
	}
	
	private enum TextSet {
		static let titleLabelText: String = "일정을 알려주세요"
		static let searchLabelText: String = "위치 검색"
		static let popularSearchLabelText: String = "인기 검색어"
	}
	
	// MARK: - UI PROPERTY
	private let titleLabel: UILabel = UILabel().then {
		$0.text = TextSet.titleLabelText
		$0.font = AppTheme.Font.Bold_20
		$0.textColor = AppTheme.Color.black
	}
	
	private let containerView: UIView = UIView().then {
		$0.backgroundColor = .blue
	}
	
	// MARK: - PROPERTY
	fileprivate let popularSpots: BehaviorRelay<[String]> = .init(value: [])
	fileprivate let selectedSpot: BehaviorRelay<String?> = .init(value: nil)
	
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
private extension TravelDateExtendedView {
	func setupConfigure() {
		backgroundColor = AppTheme.Color.white
	}
	
	func setupSubViews() {
		addSubview(titleLabel)
		addSubview(containerView)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(24)
			make.horizontalEdges.equalToSuperview().inset(22)
		}
		
		containerView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(22)
			make.horizontalEdges.equalToSuperview().inset(20)
			make.bottom.equalToSuperview().inset(20)
		}
	}
}

// MARK: - COLLECTIONVIEW {

// MARK: - REACTIVE EXTENSION
extension Reactive where Base: TravelDateExtendedView {
	
}

