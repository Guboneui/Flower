//
//  ProfileViewModel.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import Foundation

import DesignSystem

public struct ProfileViewModel: Equatable {
	var userInfo: [UserInfoCellectionViewCellViewModel]?
	var userInfoSeparateLine: [CollectionViewSeparateLineCellViewModel] = [.init()]
	var userActivity: [UserActivityCollectionViewCellViewModel]?
	var serviceManagement: [ServiceManagementCollectionViewCelViewModel]?
}
