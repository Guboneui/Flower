//
//  UserInfoCellectionViewCellViewModel.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import Foundation

struct UserInfoCellectionViewCellViewModel: Hashable, Equatable {
	let profileImageURL: String
	let userName: String
	let userEmail: String
	let userLoginType: String
}
