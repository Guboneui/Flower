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
	public var name: String?
	public var nickname: String?
	public var birth: String?
	public var avatar: Data?
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
		self.name = userName
		self.nickname = userNickName
		self.birth = birth
		self.avatar = profileImg
		self.phoneNum = phoneNum
	}
}
