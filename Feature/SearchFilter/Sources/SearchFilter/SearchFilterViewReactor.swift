//
//  SearchFilterViewReactor.swift
//  SearchFilter
//
//  Created by 구본의 on 2023/11/27.
//

import UIKit

import ReactorKit
import RxSwift

public final class SearchFilterViewReactor: Reactor {
	
	public enum Action {
		case didTapSpotView
		case didTapGroupView
		case didTapDecreaseButton
		case didTapIncreaseButton
	}
	
	public enum Mutation {
		case setTravelSpotViewToExtend
		case setTravelGroupViewToExtend
		case decreaseValue
		case increaseValue
	}
	
	public struct State {
		var isExtendedSpotView: Bool
		var isExtendedGroupView: Bool
		var groupCount: Int
	}
	
	public var initialState: State
	
	public init() {
		self.initialState = State(
			isExtendedSpotView: true,
			isExtendedGroupView: false,
			groupCount: 0
		)
	}
	
	public func mutate(action: Action) -> Observable<Mutation> {
		switch action {
		case .didTapSpotView:
			return performDidTapSpotView()
		case .didTapGroupView:
			return performDidTapGroupView()
		case .didTapDecreaseButton:
			return performDidTapDecreaseButton()
		case .didTapIncreaseButton:
			return performDidTapIncreaseButton()
		}
	}
	
	public func reduce(state: State, mutation: Mutation) -> State {
		var state = state
		
		switch mutation {
		case .setTravelSpotViewToExtend:
			state.isExtendedSpotView.toggle()
		case .setTravelGroupViewToExtend:
			state.isExtendedGroupView.toggle()
		case .decreaseValue:
			if state.groupCount > 0 {
				state.groupCount -= 1
			}
		case .increaseValue:
			if state.groupCount < 6 {
				state.groupCount += 1
			}
		}
		
		return state
	}
}

// MARK: - PRIVATE METHOD
private extension SearchFilterViewReactor {
	func performDidTapSpotView() -> Observable<Mutation> {
		return .just(.setTravelSpotViewToExtend)
	}
	
	func performDidTapGroupView() -> Observable<Mutation> {
		return .just(.setTravelGroupViewToExtend)
	}
	
	func performDidTapDecreaseButton() -> Observable<Mutation> {
		return .just(.decreaseValue)
	}
	
	func performDidTapIncreaseButton() -> Observable<Mutation> {
		return .just(.increaseValue)
	}
}
