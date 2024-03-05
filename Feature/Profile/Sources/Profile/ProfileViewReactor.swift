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
		case tapEditProfileButton
	}
	
	public enum Mutation {
		case setCollectionViewModel(ProfileViewModel)
		case setRouter(ProfileRouter)
	}
	
	public struct State {
		// MARK: Pulse
		@Pulse var router: ProfileRouter?

		// MARK: Property
		var collectionViewModel: ProfileViewModel
	}
	
	public var initialState: State
	
	public init() {
		initialState = .init(
			collectionViewModel: .init()
		)
	}
	
	public func mutate(
		action: Action
	) -> Observable<Mutation> {
		switch action {
		case .load:
			return performLoad()
		case .tapEditProfileButton:
			return performRouter(to: .profileEdit)
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
		case let .setRouter(router):
			state.router = router
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
					userSchedule: fetchUserScheduleCellectionViewCellViewModel(),
					userActivity: fetchUserActivityCollectionViewCellViewModel(),
					serviceManagement: fetchServiceManagementCollectionViewCellViewModel()
				)
			)
		)
	}
	
	func performRouter(to router: ProfileRouter) -> Observable<Mutation> {
		return .just(.setRouter(router))
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
	
	func fetchUserScheduleCellectionViewCellViewModel() -> [UserScheduleCollectionViewCellViewModel]? {
		let userSchedule: UserScheduleCollectionViewCellViewModel = .init(
			imageURL: "",
			guestHouseName: "연남 민박",
			guestHouseRoomName: "패밀리 룸",
			checkInDate: "2월 22일 15:00",
			checkOutDate: "2월 22일 15:00",
			guestHousePrice: "298,000원 / 6박"
		)
		return [userSchedule]
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
	
	func fetchServiceManagementCollectionViewCellViewModel() -> [ServiceManagementCollectionViewCelViewModel] {
		let serviceManagements: [ServiceManagementCollectionViewCelViewModel] = [
			.init(title: "공지사항"),
			.init(title: "설정"),
			.init(title: "앱 정보")
		]
		return serviceManagements
	}
}
