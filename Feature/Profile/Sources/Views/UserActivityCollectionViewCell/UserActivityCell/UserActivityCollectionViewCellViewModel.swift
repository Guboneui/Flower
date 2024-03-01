//
//  UserActivityCollectionViewCellViewModel.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import Foundation

struct UserActivityCollectionViewCellViewModel: Hashable, Equatable {
	var recentCount: Int
	var reservationCount: Int
	var bookmarkCount: Int
	var reviewCount: Int
}
