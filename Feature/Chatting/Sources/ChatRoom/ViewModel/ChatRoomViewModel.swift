//
//  ChatRoomViewModel.swift
//  Chatting
//
//  Created by 김동겸 on 1/16/24.
//

import Foundation

import ChattingDomain
import ChattingEntity

import RxRelay
import RxSwift

public struct DisplayableMessageModel {
	public let data: String
	public let time: String
	public let uid: String
	
	public var isContinuousUid: Bool
	public var isHiddenTime: Bool
	
	init(
		data: String,
		time: String,
		uid: String,
		isHiddenTime: Bool,
		isContinuousUid: Bool
	) {
		self.data = data
		self.time = time
		self.uid = uid
		self.isHiddenTime = isHiddenTime
		self.isContinuousUid = isContinuousUid
	}
}

// MARK: - VIEWMODEL INTERFACE
public protocol ChatRoomViewModelInterface {
	var isMenuOpen: BehaviorRelay<Bool> { get }
	var chattingCurrentText: BehaviorRelay<String> { get }
	var displayableMessageArray: BehaviorRelay<[DisplayableMessageModel]> { get }
	var channelInfoDTO: ChannelInfoDTO { get set }
	var channelInfoDTORelay: BehaviorRelay<ChannelInfoDTO> { get }
	var membersDictionary: [String: String] { get }
	
	func enteredChattingRoom()
	func leavedChattingRoom()
	func sentMessage()
}

public final class ChatRoomViewModel: ChatRoomViewModelInterface {
	// MARK: - PUBLIC PROPERTY
	public var isMenuOpen: BehaviorRelay<Bool> = .init(value: true)
	public var chattingCurrentText: BehaviorRelay<String> = .init(value: "")
	public var displayableMessageArray: BehaviorRelay<[DisplayableMessageModel]> = .init(value: [])
	public var channelInfoDTO: ChannelInfoDTO
	public var channelInfoDTORelay: BehaviorRelay<ChannelInfoDTO>
	public var membersDictionary: [String: String] = [:]
	
	// MARK: - PRIVATE PROPERTY
	private let chatUseCase: ChatUseCaseInterface
	private let disposeBag: DisposeBag
	private var receivedMessageArrayFromSoket: [ReceiveMessageData] = []
	private var displayableMessageTempArray: [DisplayableMessageModel] = []
	
	// MARK: - INITIALIZE
	public init(useCase: ChatUseCaseInterface, channelInfoDTO: ChannelInfoDTO) {
		self.chatUseCase = useCase
		self.channelInfoDTO = channelInfoDTO
		self.disposeBag = .init()
		self.channelInfoDTORelay = .init(value: channelInfoDTO)
	}
	
	// MARK: - PUBLIC METHOD
	public func leavedChattingRoom() {
		chatUseCase.disconnectSoket()
	}
	
	public func sentMessage() {
		let cid = channelInfoDTO.id
		let sentMessageData: SendMessageData = SendMessageData(
			cid: cid,
			data: chattingCurrentText.value
		)
		
		chatUseCase.sendChatMessage(d: sentMessageData)
	}
	
	public func enteredChattingRoom() {
		chatUseCase.enterChattingRoom()
		messageBinding()
		channelMembersList()
	}
}

// MARK: - PRIVATE METHOD
private extension ChatRoomViewModel {
	func messageBinding() {
		chatUseCase.receivedChatMessageRelay
			.filter { $0.cid == self.channelInfoDTO.id } //채널 아이디 체크
			.subscribe(onNext: { [weak self] messageData in
				guard let self else { return }
				
				if receivedMessageArrayFromSoket.isEmpty {
					self.receivedMessageArrayFromSoket.append(messageData)
					self.displayableMessageTempArray = mappingArrayToDisplayableMessageModel(
						with: self.receivedMessageArrayFromSoket
					)
					
				} else {
					if messageData.time ?? "" < self.receivedMessageArrayFromSoket.last?.time ?? "" {
						self.receivedMessageArrayFromSoket.append(messageData)
						self.receivedMessageArrayFromSoket.sort(by: { $0.time ?? "" < $1.time ?? "" })
					} else {
						self.receivedMessageArrayFromSoket.append(messageData)
					}
					
					self.displayableMessageTempArray = self.mappingArrayToDisplayableMessageModel(
						with: self.receivedMessageArrayFromSoket
					)
					self.displayableMessageTempArray = self.searchForMatchingPreviousEntry(
						with: self.displayableMessageTempArray
					)
				}
				
				self.displayableMessageArray.accept(self.displayableMessageTempArray)
			}).disposed(by: disposeBag)
	}
	
	func channelMembersList() {
		chatUseCase.fetchChannelMemberList(channelID: channelInfoDTO.id)
			.subscribe(onSuccess: { [weak self] responseData in
				guard let self else { return }
				
				membersDictionary =	self.makeMembersDictionary(with: responseData.members)
				self.channelInfoDTO.members = mappingArrayToMembersInfoDTO(
					with: responseData.members
				)
				self.channelInfoDTORelay.accept(channelInfoDTO)
			}).disposed(by: disposeBag)
	}
	
	func makeMembersDictionary(with baseArray: [ChannelMemberInfo]) -> [String: String] {
		var tempDic: [String: String] = [:]
		
		baseArray.forEach({
			tempDic[$0.id] = $0.name
		})
		print(tempDic)
		return tempDic
	}
	
	func mappingArrayToDisplayableMessageModel(
		with baseArray: [ReceiveMessageData]
	) -> [DisplayableMessageModel] {
		var tempArray: [DisplayableMessageModel] = []
		
		baseArray.forEach({
			let temp: DisplayableMessageModel = .init(
				data: $0.data ?? "",
				time: stringConvertToDateTime(utcTime: $0.time ?? ""),
				uid: $0.uid ?? "",
				isHiddenTime: false,
				isContinuousUid: false
			)
			tempArray.append(temp)
		})
		
		return tempArray
	}
	
	func mappingArrayToMembersInfoDTO(
		with baseArray: [ChannelMemberInfo]
	) -> [MemberInfoDTO] {
		var tempArray: [MemberInfoDTO] = []
		
		baseArray.forEach({
			let temp: MemberInfoDTO = .init(
				id: $0.id,
				role: $0.role,
				name: $0.name,
				avatar_url: $0.avatar_url
			)
			tempArray.append(temp)
		})
		
		return tempArray
	}
	
	func searchForMatchingPreviousEntry(
		with baseArray: [DisplayableMessageModel]
	) -> [DisplayableMessageModel] {
		var tempArray: [DisplayableMessageModel] = baseArray
		
		baseArray.enumerated().forEach({
			if $0.offset != 0 {
				if $0.element.uid == baseArray[$0.offset - 1].uid {
					tempArray[$0.offset].isContinuousUid = true
					if $0.element.time == baseArray[$0.offset - 1].time {
						tempArray[$0.offset - 1].isHiddenTime = true
					} else {
						tempArray[$0.offset].isContinuousUid = false
					}
				}
			}
		})
		
		return tempArray
	}
	
	func stringConvertToDateTime(utcTime: String) -> String {
		let stringFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		let formatter = DateFormatter()
		formatter.dateFormat = stringFormat
		formatter.locale = Locale(identifier: "ko")
		guard let tempDate = formatter.date(from: utcTime) else {
			return ""
		}
		formatter.dateFormat = "HH:mm"
		
		return formatter.string(from: tempDate)
	}
}
