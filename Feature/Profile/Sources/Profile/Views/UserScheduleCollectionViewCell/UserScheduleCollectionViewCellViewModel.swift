//
//  UserScheduleCollectionViewCellViewModel.swift
//  Profile
//
//  Created by 구본의 on 2024/03/02.
//

import Foundation

struct UserScheduleCollectionViewCellViewModel: Hashable, Equatable {
	let imageURL: String
	let guestHouseName: String
	let guestHouseRoomName: String
	let checkInDate: String
	let checkOutDate: String
	let guestHousePrice: String
}
