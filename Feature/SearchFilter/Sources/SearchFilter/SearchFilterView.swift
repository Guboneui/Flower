//
//  SearchFilterView.swift
//  SearchFilter
//
//  Created by 구본의 on 2023/11/27.
//

import UIKit

import DesignSystem
import ResourceKit

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class SearchFilterView: UIView {
	
	// MARK: - METRIC
	private enum Metric {
		static let radius: CGFloat = 16
		static let spacing: CGFloat = 0
		static let guideLineHeight: CGFloat = 1.0
		
		static let bottomButtonTopMargin: CGFloat = 12
		static let bottomButtonHorizontalMargin: CGFloat = 20
		static let bottomButtonBottomMargin: CGFloat = UIDevice.hasNotch ? -66 : -32
	}
	
	// MARK: - TEXT SET
	private enum TextSet {
		static let navigationTitle: String = "필터"
		static let leftButtonTitle: String = "선택 취소"
		static let rightButtonTitle: String = "검색"
	}
	
	// MARK: - UI PROPERTY
	fileprivate let navigationBar: NavigationBar = NavigationBar(
		.close,
		title: TextSet.navigationTitle,
		hasGuideLine: true
	)
	
	private let scrollView: UIScrollView = UIScrollView()
	
	private let scrollContainerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.grey90
	}
	
	fileprivate let travelSpotDefaultView: TravelSpotDefaultView = .init()
	fileprivate let travelSpotExtendedView: TravelSpotExtendedView = .init()
	private lazy var travelSpotStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			travelSpotDefaultView,
			travelSpotExtendedView
		]).then {
			$0.backgroundColor = AppTheme.Color.white
			$0.axis = .vertical
			$0.spacing = Metric.spacing
			$0.makeCornerRadiusWithBorder(Metric.radius)
		}
	
	fileprivate let travelGroupDefaultView: TravelGroupDefaultView = .init()
	fileprivate let travelGroupExtendedView: TravelGroupExtendedView = .init()
	private lazy var travelGroupStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			travelGroupDefaultView,
			travelGroupExtendedView
		]).then {
			$0.backgroundColor = AppTheme.Color.white
			$0.axis = .vertical
			$0.spacing = Metric.spacing
			$0.makeCornerRadiusWithBorder(Metric.radius)
		}
	
	private let bottomContainerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.white
	}
	
	private let bottomContainerGuideLineView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.grey70
	}
	
	fileprivate let bottomButton: TwoButton = TwoButton(
		sizeType: .rightLarger,
		buttonType: (.origin, .primary),
		leftButtonTitle: TextSet.leftButtonTitle,
		rightButtonTitle: TextSet.rightButtonTitle
	)
	
	// MARK: - INITIALIZE
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupViewConfigure()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func updateTravelSpotViewState(isExtended: Bool) {
		UIView.animate(
			withDuration: 0.15,
			animations: {
				self.travelSpotDefaultView.isHidden = isExtended ? true : false
				self.travelSpotDefaultView.alpha = isExtended ? 0 : 1.0
				self.travelSpotExtendedView.isHidden = isExtended ? false : true
				self.travelSpotExtendedView.alpha = isExtended ? 1.0 : 0
		})
	}
	
	public func updateTravelGroupViewState(isExtended: Bool) {
		UIView.animate(
			withDuration: 0.15,
			animations: {
				self.travelGroupDefaultView.isHidden = isExtended ? true : false
				self.travelGroupDefaultView.alpha = isExtended ? 0 : 1.0
				self.travelGroupExtendedView.isHidden = isExtended ? false : true
				self.travelGroupExtendedView.alpha = isExtended ? 1.0 : 0
		})
	}
}

// MARK: - PRIVATE METHOD
private extension SearchFilterView {
	func setupViewConfigure() {
		backgroundColor = AppTheme.Color.white
		
		travelSpotDefaultView.isHidden = true
		travelSpotDefaultView.alpha = 0.0
		
		travelGroupExtendedView.isHidden = true
		travelGroupExtendedView.alpha = 0.0
	}
	
	func setupViews() {
		addSubview(navigationBar)
		addSubview(scrollView)
		scrollView.addSubview(scrollContainerView)
		scrollContainerView.addSubview(travelSpotStackView)
		scrollContainerView.addSubview(travelGroupStackView)
		addSubview(bottomContainerView)
		bottomContainerView.addSubview(bottomContainerGuideLineView)
		bottomContainerView.addSubview(bottomButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(bottomContainerView.snp.top)
		}
		
		scrollContainerView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.width.equalToSuperview()
			
			make.height.equalTo(2000)
		}
		
		travelSpotStackView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(20)
			make.horizontalEdges.equalToSuperview().inset(20)
		}
		
		travelGroupStackView.snp.makeConstraints { make in
			make.top.equalTo(travelSpotStackView.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(20)
		}
		
		bottomContainerView.snp.makeConstraints { make in
			make.bottom.equalToSuperview()
			make.horizontalEdges.equalToSuperview()
		}
		
		bottomContainerGuideLineView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(Metric.guideLineHeight)
		}
		
		bottomButton.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.bottomButtonTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.bottomButtonHorizontalMargin)
			make.bottom.equalToSuperview().offset(Metric.bottomButtonBottomMargin)
		}
	}
}

// MARK: - Reactive Extension
extension Reactive where Base: SearchFilterView {
	var didTapNavigationLeftButton: ControlEvent<Void> {
		let source = base.navigationBar.rx.tapLeftButton.asObservable()
		return ControlEvent(events: source)
	}
	
	var didTapBottomLeftButton: ControlEvent<Void> {
		let source = base.bottomButton.rx.tapLeftButton.asObservable()
		return ControlEvent(events: source)
	}
	
	var didTapBottomRightButton: ControlEvent<Void> {
		let source = base.bottomButton.rx.tapRightButton.asObservable()
		return ControlEvent(events: source)
	}
	
	// MARK: - Travel Spot
	var didTapTravelSpotDefaultView: ControlEvent<Void> {
		let source = base.travelSpotDefaultView.rx.tapGesture().when(.recognized).map { _ in }
		return ControlEvent(events: source)
	}
	
	var didTapLocationSearchContainer: ControlEvent<Void> {
		let source = base.travelSpotExtendedView.rx.didTapLocationSearchContainer
		return ControlEvent(events: source)
	}
	
	var popularSpots: Binder<[String]> {
		return Binder(base) { view, popularSpots in
			view.travelSpotExtendedView.rx.popularSpotsRelay.onNext(popularSpots)
		}
	}
	
	var selectedSpotValueInDefaultView: Binder<String> {
		return base.travelSpotDefaultView.rx.selectedSpot
	}
	
	var selectedSpotValueInExtendedView: Binder<String> {
		return base.travelSpotExtendedView.rx.selectedSpot
	}
	
	var selectedSpotRelay: Observable<String?> {
		return base.travelSpotExtendedView.rx.selectedSpotRelay
	}
	
	// MARK: - Travel Group
	var didTapTravelGroupDefaultView: ControlEvent<Void> {
		let source = base.travelGroupDefaultView.rx.tapGesture().when(.recognized).map { _ in }
		return ControlEvent(events: source)
	}
	
	var didTapDecreaseButton: ControlEvent<Void> {
		let source = base.travelGroupExtendedView.rx.tapDecreaseButton.asObservable()
		return ControlEvent(events: source)
	}
	
	var didTapIncreaseButton: ControlEvent<Void> {
		let source = base.travelGroupExtendedView.rx.tapIncreaseButton.asObservable()
		return ControlEvent(events: source)
	}
	
	var isEnableIncreaseButton: Binder<Bool> {
		return base.travelGroupExtendedView.rx.increaseButtonEnable
	}
	
	var isEnableDecreaseButton: Binder<Bool> {
		return base.travelGroupExtendedView.rx.decreaseButtonEnable
	}
	
	var groupCounterValueInDefaultView: Binder<String> {
		return base.travelGroupDefaultView.rx.counterValue
	}
	
	var groupCounterValueInExtendedView: Binder<String> {
		return base.travelGroupExtendedView.rx.counterValue
	}
}
