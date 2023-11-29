//
//  SearchFilterViewController.swift
//  SearchFilterDemoApp
//
//  Created by 구본의 on 2023/11/19.
//

import UIKit

import DesignSystem
import ResourceKit

import ReactorKit
import RxSwift
import SnapKit
import Then

public final class SearchFilterViewController: UIViewController, View {
	
	private enum Constant {
		static let minumumGroupCount: Int = 0
		static let maximumGroupCount: Int = 6
	}
	
	// MARK: - UI PROPERTY
	private let rootView: SearchFilterView = SearchFilterView()
	
	// MARK: - PROPERTY
	public var disposeBag: DisposeBag = .init()
	
	// MARK: - LIFE CYCLE
	public override func loadView() {
		super.loadView()
		self.view = rootView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		self.setupGestures()
	}
	
	// MARK: - BINDING
	public func bind(reactor: SearchFilterViewReactor) {
		rootView.rx.didTapDecreaseButton
			.map { .didTapDecreaseButton }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		rootView.rx.didTapIncreaseButton
			.map { .didTapIncreaseButton }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		rootView.rx.didTapTravelSpotStackView
			.map { .didTapSpotView }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		rootView.rx.didTapTravelGroupStackView
			.map { .didTapGroupView }
			.bind(to: reactor.action)
			.disposed(by: disposeBag)
		
		reactor.state.map(\.isExtendedSpotView)
			.distinctUntilChanged()
			.observe(on: MainScheduler.instance)
			.bind { [weak self] isExtended in
				guard let self else { return }
				self.rootView.updateTravelSpotViewState(isExtended: isExtended)
			}.disposed(by: disposeBag)
		
		reactor.state.map(\.isExtendedGroupView)
			.distinctUntilChanged()
			.observe(on: MainScheduler.instance)
			.bind { [weak self] isExtended in
				guard let self else { return }
				self.rootView.updateTravelGroupViewState(isExtended: isExtended)
			}.disposed(by: disposeBag)
		
		let groupCount = reactor.state.map(\.groupCount)
			.distinctUntilChanged()
			.share()
		
		groupCount
			.map { String($0) }
			.bind(to: rootView.rx.groupCounterValueInExtendedView)
			.disposed(by: disposeBag)
		
		groupCount
			.map { "\($0) 명" }
			.bind(to: rootView.rx.groupCounterValueInDefaultView)
			.disposed(by: disposeBag)
		
		groupCount
			.map { $0 > Constant.minumumGroupCount }
			.bind(to: rootView.rx.isEnableDecreaseButton)
			.disposed(by: disposeBag)
		
		groupCount
			.map { $0 < Constant.maximumGroupCount }
			.bind(to: rootView.rx.isEnableIncreaseButton)
			.disposed(by: disposeBag)
	}
}

// MARK: - PRIVATE METHOD
private extension SearchFilterViewController {
	func setupGestures() {
		rootView.rx.didTapNavigationLeftButton
			.bind { [weak self] in
				guard let self else { return }
				self.dismiss(animated: true)
			}.disposed(by: disposeBag)
	}
}
