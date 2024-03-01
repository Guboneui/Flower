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
		let userInfo: [UserInfoCellectionViewCellViewModel] = fetchUserInfoCellectionViewCellViewModel()
		return .just(
			.setCollectionViewModel(
				ProfileViewModel(
					userInfo: userInfo
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
}
