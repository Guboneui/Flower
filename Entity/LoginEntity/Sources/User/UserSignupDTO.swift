//
//  UserSignupDTO.swift
//  LoginEntity
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

public struct UserSignupDTO {
	public var email: String?
	public var password: String?
	public var userName: String?
	public var userNickName: String?
	public var birth: String?
	public var profileImg: Data?
	public var phoneNum: String?
	
	public init(
		email: String?,
		password: String?,
		userName: String?,
		userNickName: String?,
		birth: String?,
		profileImg: Data?,
		phoneNum: String?
	) {
		self.email = email
		self.password = password
		self.userName = userName
		self.userNickName = userNickName
		self.birth = birth
		self.profileImg = profileImg
		self.phoneNum = phoneNum
	}
}
