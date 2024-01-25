//
//  ChattingViewController.swift
//  ChattingDemoApp
//
//  Created by 구본의 on 2023/12/28.
//

import UIKit

import RxSwift

public final class ChattingRoomViewController: UIViewController {
	// MARK: - UI Property
	private let rootView: ChattingRoomView = ChattingRoomView()
	
	// MARK: - Property
	private let chattingRoomViewModel: ChattingRoomViewModelInterface
	private let disposeBag: DisposeBag = DisposeBag()
	
	// MARK: - INITIALIZE
	public init(chattingRoomViewModel: ChattingRoomViewModelInterface) {
		self.chattingRoomViewModel = chattingRoomViewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - LifeCycle
	public override func loadView() {
		view = rootView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupBinds()
		setupGestures()
	}
}

// MARK: - PRIVATE METHOD
private extension ChattingRoomViewController {
	func setupBinds() {
		chattingRoomViewModel.isMenuOpen
			.subscribe(onNext: { [weak self] isMenuOpen in
				guard let self else { return }
				
				self.rootView.addPhotoMenuButtonAnimation(with: isMenuOpen)
			}).disposed(by: disposeBag)
		
		rootView.rx.inputMessageTextViewCurrentText
			.map { $0 ?? "" }
			.subscribe(onNext: { [weak self] chattingText in
				guard let self else { return }
				
				self.chattingRoomViewModel.chattingCurrentText.accept(chattingText)
				self.rootView.sendMessageButtonAnimation(with: chattingText.isEmpty)
			}).disposed(by: disposeBag)
		
		rootView.rx.didChangeInputMessageTextView
			.subscribe(onNext: { [weak self] in
				guard let self else { return }
				
				self.rootView.setSizingInputMessageTextView()
			}).disposed(by: disposeBag)
	}
	
	func setupGestures() {
		rootView.rx.didTapAddPhotoMenuButton
			.bind(onNext: { [weak self] in
				guard let self else { return }
				
				chattingRoomViewModel.isMenuOpen
					.accept(!chattingRoomViewModel.isMenuOpen.value)
			}).disposed(by: disposeBag)
		
		rootView.rx.didTapSendMessageButton
			.bind(onNext: { [weak self] in
				guard let self else { return }
				
				rootView.sendMessageButtonAnimation(with: true)
				rootView.setOriginalSizingInputMessageTextView()
			}).disposed(by: disposeBag)
		
		rootView.rx.didTapChattingRoomCollectionView
			.bind(onNext: { [weak self] _ in
				guard let self else { return }
				
				self.view.endEditing(true)
			}).disposed(by: disposeBag)
	}
}
