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
		case updateExtendedState(SearchFilterExtendedState)
		case didTapDecreaseButton
		case didTapIncreaseButton
	}
	
	public enum Mutation {
		case decreaseValue
		case increaseValue
		case setExtendedState(SearchFilterExtendedState)
	}
	
	public struct State {
		var extendedState: SearchFilterExtendedState
		var groupCount: Int
	}
	
	public var initialState: State
	
	public init() {
		self.initialState = State(
			extendedState: .travelSpot,
			groupCount: 0
		)
	}
	
	public func mutate(action: Action) -> Observable<Mutation> {
		switch action {
		case let .updateExtendedState(extenedState):
			return performExtenedState(with: extenedState)
		case .didTapDecreaseButton:
			return performDidTapDecreaseButton()
		case .didTapIncreaseButton:
			return performDidTapIncreaseButton()
		}
	}
	
	public func reduce(state: State, mutation: Mutation) -> State {
		var state = state
		
		switch mutation {
		case .decreaseValue:
		case let .setExtendedState(extendedState):
			state.extendedState = extendedState
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
	
	func performExtenedState(with extendedState: SearchFilterExtendedState) -> Observable<Mutation> {
		return .just(.setExtendedState(extendedState))
	}
	
	}
	
	func performDidTapDecreaseButton() -> Observable<Mutation> {
		return .just(.decreaseValue)
	}
	
	func performDidTapIncreaseButton() -> Observable<Mutation> {
		return .just(.increaseValue)
	}
}
