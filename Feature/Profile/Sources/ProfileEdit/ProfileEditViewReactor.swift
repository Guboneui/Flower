//
//  ProfileEditViewReactor.swift
//  Profile
//
//  Created by 구본의 on 2024/03/07.
//

import ResourceKit

import ReactorKit

public final class ProfileEditViewReactor: Reactor {
	public enum Action {
		case load
	}
	
	public enum Mutation {
		
	}
	
	public struct State {
		// MARK: Pulse

		// MARK: Property
		var nameViewModel: ProfileEditStackViewModel
		var emailViewModel: ProfileEditStackViewModel
		var passwordViewModel: ProfileEditStackViewModel
		var phoneNumberViewModel: ProfileEditStackViewModel
	}
	
	public var initialState: State
	
	public init() {
		initialState = .init(
			nameViewModel: .init(
				title: "이름",
				contents: "구본의"
			),
			emailViewModel: .init(
				title: "이메일",
				contents: "test@naver.com",
				image: AppTheme.Image.naverLogin,
				isEditable: true
			),
			passwordViewModel: .init(
				title: "비밀번호",
				contents: "••••••••",
				isEditable: true
			),
			phoneNumberViewModel: .init(
				title: "핸드폰번호",
				contents: "010-****-****",
				isEditable: true
			)
		)
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
		return state
	}
}

// MARK: - Mutate Method
private extension ProfileEditViewReactor {
	func performLoad() -> Observable<Mutation> {
		return .empty()
	}
}

// MARK: - Private Method
private extension ProfileEditViewReactor {
	
}
