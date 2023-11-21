//
//  SearchFilterViewController.swift
//  SearchFilterDemoApp
//
//  Created by 구본의 on 2023/11/19.
//

import UIKit

import DesignSystem
import ResourceKit

import RxSwift
import SnapKit
import Then

public final class SearchFilterViewController: UIViewController {
	
	// MARK: METRIC
	private enum Metric {
		static let guideLineHeight: CGFloat = 1.0
		
		static let bottomButtonTopMargin: CGFloat = 12
		static let bottomButtonHorizontalMargin: CGFloat = 20
		static let bottomButtonBottomMargin: CGFloat = UIDevice.hasNotch ? -66 : -32
	}
	
	// MARK: - UI PROPERTY
	private let navigationBar: NavigationBar = NavigationBar(
		.close,
		title: "필터",
		hasGuideLine: true
	)
	
	private let containerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.grey90
	}
	
	private let travelSpotSelectorView: TravelSpotSelectorView = .init()
	private let travelGroupSelectorView: TravelGroupSelectorView = .init()
	
	private let bottomContainerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.white
	}
	
	private let bottomContainerGuideLineView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.grey70
	}
	
	private let bottomButton: TwoButton = TwoButton(
		sizeType: .rightLarger,
		buttonType: (.origin, .primary),
		leftButtonTitle: "선택 취소",
		rightButtonTitle: "검색"
	)
	
	
	
	// MARK: - PROPERTY
	private let disposeBag: DisposeBag = DisposeBag()
	
	// MARK: - LIFE CYCLE
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupViewConfigure()
		setupViews()
		setupGestures()
	}
}

// MARK: - PRIVATE METHOD
private extension SearchFilterViewController {
	func setupViewConfigure() {
		view.backgroundColor = AppTheme.Color.white
	}
	
	func setupViews() {
		view.addSubview(navigationBar)
		view.addSubview(containerView)
		containerView.addSubview(travelSpotSelectorView)
		containerView.addSubview(travelGroupSelectorView)
		view.addSubview(bottomContainerView)
		bottomContainerView.addSubview(bottomContainerGuideLineView)
		bottomContainerView.addSubview(bottomButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		containerView.snp.makeConstraints { make in
			make.top.equalTo(navigationBar.snp.bottom)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(bottomContainerView.snp.top)
		}
		
		travelSpotSelectorView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(20)
			make.horizontalEdges.equalToSuperview().inset(20)
		}
		
		travelGroupSelectorView.snp.makeConstraints { make in
			make.top.equalTo(travelSpotSelectorView.snp.bottom).offset(20)
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
	
	func setupGestures() {
		navigationBar.rx.tapLeftButton
			.bind { [weak self] in
				guard let self else { return }
				self.dismiss(animated: true)
			}.disposed(by: disposeBag)
		
		bottomButton.rx.tapLeftButton
			.bind { [weak self] in
				guard let self else { return }
				let prevState = self.travelSpotSelectorView.currentState.value
				self.travelSpotSelectorView.currentState.accept(!prevState)
			}.disposed(by: disposeBag)
		
		bottomButton.rx.tapRightButton
			.bind { [weak self] in
				guard let self else { return }
				print("검색")
			}.disposed(by: disposeBag)
	}
}
