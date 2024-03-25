//
//  UserManager.swift
//  UserStorageKit
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

public final class UserManager {
	// MARK: - Property
	public static let shared: UserManager = UserManager()
	
	public var name: String?
	public var profileImageURL: String?
	
	// MARK: - Initialize
	private init() { }
	
	// MARK: - Public Method
	public func clearUser() {
		name = nil
		profileImageURL = nil
	}
}
