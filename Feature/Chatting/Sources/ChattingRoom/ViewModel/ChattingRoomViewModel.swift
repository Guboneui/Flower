//
//  ChattingRoomViewModel.swift
//  Chatting
//
//  Created by 김동겸 on 1/16/24.
//

import RxRelay

// MARK: - VIEWMODEL INTERFACE
public protocol ChattingRoomViewModelInterface {
	var isMenuOpen: BehaviorRelay<Bool> { get }
	var chattingCurrentText: BehaviorRelay<String> { get }
}

public final class ChattingRoomViewModel: ChattingRoomViewModelInterface {
	public var isMenuOpen: BehaviorRelay<Bool> = .init(value: true)
	public var chattingCurrentText: BehaviorRelay<String> = .init(value: "")
	
	public init() { }
}
