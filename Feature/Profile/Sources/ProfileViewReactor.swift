//
//  ProfileViewReactor.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import ReactorKit

public final class ProfileViewReactor: Reactor {
	public enum Action {
		case load
	}
	
	public enum Mutation {
		case setCollectionViewModel(ProfileViewModel)
	}
	
	public struct State {
		var collectionViewModel: ProfileViewModel = .init()
	}
	
	public var initialState: State
	
	public init() {
		initialState = .init()
	}
	
	public func mutate(
		action: Action
	) -> Observable<Mutation> {
		switch action {
		case .load:
			return performLoad()
		}
	}
	
	public func reduce(
		state: State,
		mutation: Mutation
	) -> State {
		var state = state
		
		switch mutation {
		case let .setCollectionViewModel(viewModel):
			state.collectionViewModel = viewModel
		}
		
		return state
	}
}

// MARK: - Mutate Method
private extension ProfileViewReactor {
	func performLoad() -> Observable<Mutation> {
		return .just(
			.setCollectionViewModel(
				ProfileViewModel(
					userInfo: fetchUserInfoCellectionViewCellViewModel(),
					userActivity: fetchUserActivityCollectionViewCellViewModel(),
				)
			)
		)
	}
}

// MARK: - Private Method
private extension ProfileViewReactor {
	func fetchUserInfoCellectionViewCellViewModel() -> [UserInfoCellectionViewCellViewModel] {
		let userInfo: UserInfoCellectionViewCellViewModel = .init(
			profileImageURL: "",
			userName: "",
			userEmail: "",
			userLoginType: ""
		)
		return [userInfo]
	}
	
	func fetchUserActivityCollectionViewCellViewModel() -> [UserActivityCollectionViewCellViewModel] {
		let userActivity: UserActivityCollectionViewCellViewModel = .init(
			recentCount: 1, 
			reservationCount: 2,
			bookmarkCount: 3,
			reviewCount: 4
		)
		return [userActivity]
	}
}
