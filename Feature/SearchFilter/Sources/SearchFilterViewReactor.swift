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
		case didTapGroupView
		case didTapDecreaseButton
		case didTapIncreaseButton
	}
	
	public enum Mutation {
		case setToExtend
		case decreaseValue
		case increaseValue
	}
	
	public struct State {
		var isExtendedGroupView: Bool = false
		var groupCount: Int
	}
	
	public var initialState: State
	
	public init() {
		self.initialState = State(
			isExtendedGroupView: false,
			groupCount: 0
		)
	}
	
	public func mutate(action: Action) -> Observable<Mutation> {
		switch action {
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
		case .setToExtend:
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
	func performDidTapGroupView() -> Observable<Mutation> {
		return .just(.setToExtend)
	}
	
	func performDidTapDecreaseButton() -> Observable<Mutation> {
		return .just(.decreaseValue)
	}
	
	func performDidTapIncreaseButton() -> Observable<Mutation> {
		return .just(.increaseValue)
	}
}
