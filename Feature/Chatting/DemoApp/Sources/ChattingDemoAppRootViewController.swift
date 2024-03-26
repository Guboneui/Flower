//
//  ChattingDemoAppRootViewController.swift
//  ChattingDemoApp
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

import Chatting
import ResourceKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class ChattingDemoAppRootViewController: UIViewController {
	
	private let moveToChatButton: UIButton = UIButton(type: .system).then {
		$0.backgroundColor = AppTheme.Color.neutral100
		$0.tintColor = AppTheme.Color.neutral900
		$0.setTitle("채팅 바로가기", for: .normal)
		$0.titleLabel?.font = AppTheme.Font.Bold_14
	}
	
	private let disposeBag: DisposeBag = .init()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = AppTheme.Color.white
		setupViews()
		setupGestures()
	}
	
	private func setupViews() {
		view.addSubview(moveToChatButton)
		moveToChatButton.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.size.equalTo(100)
		}
	}
	
	private func setupGestures() {
		moveToChatButton.rx.tap
			.bind { [weak self] in
				guard let self else { return }
				let viewModel: ChattingRoomViewModelInterface = ChattingRoomViewModel()
				let chattingViewController: ChattingRoomViewController =
				ChattingRoomViewController(chattingRoomViewModel: viewModel)
				chattingViewController.modalPresentationStyle = .overFullScreen
				self.present(chattingViewController, animated: true)
			}.disposed(by: disposeBag)
	}
}
