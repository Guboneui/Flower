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
		case tapProfileImageEditButton
		case tapNavigationButton
		case tapEmailEditButton
		case tapPasswordEditButton
		case tapPhoneNumberEditButton
	}
	
	public enum Mutation {
		case setRouter(ProfileEditRouter)
	}
	
	public struct State {
		// MARK: Pulse
		@Pulse var router: ProfileEditRouter?

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
		case .tapNavigationButton:
			return performRouter(to: .back)
		case .tapProfileImageEditButton:
			return performRouter(to: .editProfileImage)
		case .tapEmailEditButton:
			return performRouter(to: .editEmail)
		case .tapPasswordEditButton:
			return performRouter(to: .editPassword)
		case .tapPhoneNumberEditButton:
			return performRouter(to: .editPhoneNumber)
		}
	}
	
	public func reduce(
		state: State,
		mutation: Mutation
	) -> State {
		var state = state
		switch mutation {
		case let .setRouter(router):
			state.router = router
		}
		return state
	}
}

// MARK: - Mutate Method
private extension ProfileEditViewReactor {
	func performLoad() -> Observable<Mutation> {
		return .empty()
	}
	
	func performRouter(to router: ProfileEditRouter) -> Observable<Mutation> {
		return .just(.setRouter(router))
	}
}

// MARK: - Private Method
private extension ProfileEditViewReactor {
	
}
