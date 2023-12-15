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
		
		static let topMargin: CGFloat = 24
		static let horizontalMargin: CGFloat = 22
		static let searchButtonBottomMargin: CGFloat = -44
	}
	
	private enum TextSet {
		static let titleLabelText: String = "일정을 알려주세요"
		static let searchText: String = "검색하기"
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
	
	fileprivate let searchButton: DefaultButton = DefaultButton(title: TextSet.searchText)
	
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
		addSubview(searchButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.topMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
		}
		
		containerView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(Metric.topMargin)
			make.horizontalEdges.equalToSuperview().inset(20)
			make.bottom.equalTo(searchButton.snp.top).offset(-20)
		}
		
		searchButton.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
			make.bottom.equalToSuperview().offset(Metric.searchButtonBottomMargin)
		}
	}
}

// MARK: - COLLECTIONVIEW {

// MARK: - REACTIVE EXTENSION
extension Reactive where Base: TravelDateExtendedView {
	var didTapSearchDateButton: ControlEvent<Void> {
		let source: Observable<Void> = base.searchButton.rx.tap.asObservable()
		return ControlEvent(events: source)
	}
}
