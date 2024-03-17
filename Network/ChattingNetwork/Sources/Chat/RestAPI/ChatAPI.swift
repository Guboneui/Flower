//
//  ChatAPI.swift
//  ChattingNetwork
//
//  Created by 김동겸 on 3/4/24.
//

import Foundation

import SecureStorageKit

import Moya

public enum ChatAPI {
	case channelList
	case channelMemberList(channelID: String)
	case channelMessageHistory(channelID: String, before: String?, limit: String?)
}

extension ChatAPI: TargetType {
	public var baseURL: URL { return GuestHouseAPIInfo.channelURL }
	
	public var path: String {
		switch self {
		case .channelList:
			return ""
			
		case let .channelMemberList(channelID):
			return "/\(channelID)/member"
			
		case let .channelMessageHistory(channelID, before, limit):
			return "/\(channelID)/message?before=\(before ?? "")&limit=\(limit ?? "")"
		}
	}
	
	public var method: Moya.Method {
		switch self {
		case .channelList, .channelMemberList, .channelMessageHistory:
			return .get
		}
	}
	
	public var task: Moya.Task {
		switch self {
		case .channelList, .channelMemberList, .channelMessageHistory:
			return .requestPlain
		}
	}
	
	public var headers: [String: String]? {
		guard let token: String = KeyChainManager.read(key: .accessToken) else { return nil }
		switch self {
		case .channelList, .channelMemberList, .channelMessageHistory:
			return ["Content-Type": "application/json",
							"Authorization": "Bearer " + token]
		}
	}
}
