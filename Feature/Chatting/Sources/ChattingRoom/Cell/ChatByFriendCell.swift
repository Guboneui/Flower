//
//  ChatByFriendCell.swift
//  Chatting
//
//  Created by 김동겸 on 1/15/24.
//

import UIKit

import DesignSystem
import ResourceKit
import UtilityKit

import SnapKit
import Then

final class ChatByFriendCell: UICollectionViewCell {
	// MARK: - METRIC
	private enum Metric {
		static let messageBubbleViewCornerRadius: CGFloat = 12
		static let messageBubbleViewAddWidthtMargin: CGFloat = 20
		static let messageBubbleViewAddHeightMargin: CGFloat = 16
		static let messageBubbleViewLeftMargin: CGFloat = 56
		static let messageBubbleViewBottomMargin: CGFloat = 4
		
		static let messageLabelNumberOfLines: Int = 0
		static let messageLabelVerticalMargin: CGFloat = 8
		static let messageLabelHorizontalMargin: CGFloat = 8
		
		static let timeLabelLeftMargin: CGFloat = 4
	}
	
	// MARK: - UI Property
	private let messageBubbleView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.secondary
		$0.makeCornerRadius(Metric.messageBubbleViewCornerRadius)
	}
	
	public let messageLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Regular_12
		$0.textColor = AppTheme.Color.black
		$0.numberOfLines = Metric.messageLabelNumberOfLines
		$0.lineBreakMode = .byCharWrapping
	}
	
	private let timeLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Regular_10
		$0.textColor = AppTheme.Color.black
	}
	
	// MARK: - Iitialize
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - PUBLIC METHOD
	public func remakeCellConstraints() {
		messageBubbleView.snp.remakeConstraints { make in
			guard let messageText = messageLabel.text else { return }
			let estimatedFrame = messageText.getEstimatedFrame(with: messageLabel.font)
			
			make.width.equalTo(estimatedFrame.width + Metric.messageBubbleViewAddWidthtMargin)
			make.height.equalTo(estimatedFrame.height + Metric.messageBubbleViewAddHeightMargin)
			make.top.equalToSuperview()
			make.leading.equalToSuperview().inset(Metric.messageBubbleViewLeftMargin)
			make.bottom.equalToSuperview().inset(Metric.messageBubbleViewBottomMargin)
		}
	}
}

// MARK: - Viewable METHOD
extension ChatByFriendCell: Viewable {
	func setupConfigures() {
		self.backgroundColor = AppTheme.Color.grey90
	}
	
	func setupViews() {
		self.addSubview(messageBubbleView)
		messageBubbleView.addSubview(messageLabel)
		self.addSubview(timeLabel)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		messageBubbleView.snp.makeConstraints { make in
			guard let messageText = messageLabel.text else { return }
			let estimatedFrame = messageText.getEstimatedFrame(with: messageLabel.font)
			
			make.width.equalTo(estimatedFrame.width + Metric.messageBubbleViewAddWidthtMargin)
			make.height.equalTo(estimatedFrame.height + Metric.messageBubbleViewAddHeightMargin)
			make.top.equalToSuperview()
			make.leading.equalToSuperview().inset(Metric.messageBubbleViewLeftMargin)
			make.bottom.equalToSuperview().inset(Metric.messageBubbleViewBottomMargin)
		}
		
		messageLabel.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview().inset(Metric.messageLabelVerticalMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.messageLabelHorizontalMargin)
		}
		
		timeLabel.snp.makeConstraints { make in
			make.bottom.equalTo(messageBubbleView.snp.bottom)
			make.leading.equalTo(messageBubbleView.snp.trailing).offset(Metric.timeLabelLeftMargin)
		}
	}
	
	func setupBinds() { }
}
