//
//  ChatByFriendWithProfileImageCell.swift
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

final class ChatByFriendWithProfileImageCell: UICollectionViewCell {
	// MARK: - METRIC
	private enum Metric {
		static let profileImageViewCornerRadius: CGFloat = 18
		static let profileImageViewSize: CGFloat = 36
		static let profileImageViewTopMargin: CGFloat = 8
		static let profileImageViewLeftMargin: CGFloat = 12
		
		static let userNameLabelLeftMargin: CGFloat = 8
		
		static let messageBubbleViewCornerRadius: CGFloat = 12
		static let messageBubbleViewAddWidthtMargin: CGFloat = 20
		static let messageBubbleViewAddHeightMargin: CGFloat = 16
		static let messageBubbleViewTopMargin: CGFloat = 4
		static let messageBubbleViewBottomMargin: CGFloat = 4
		
		static let messageLabelNumberOfLines: Int = 0
		static let messageLabelVerticalMargin: CGFloat = 8
		static let messageLabelHorizontalMargin: CGFloat = 8
		
		static let timeLabelLeftMargin: CGFloat = 4
	}
	
	// MARK: - TextSet
	private enum TextSet {
		static let identifier: String = "ChatByFriendWithProfileImageCell"
	}
	
	// MARK: - UI Property
	private let profileImageView: UIImageView = UIImageView().then {
		$0.backgroundColor = .orange
		$0.makeCornerRadius(Metric.profileImageViewCornerRadius)
	}
	
	public let userNameLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Regular_12
		$0.textColor = AppTheme.Color.black
	}
	
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
	
	// MARK: - Property
	static let identifier = TextSet.identifier
	
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
			make.top.equalTo(userNameLabel.snp.bottom).offset(Metric.messageBubbleViewTopMargin)
			make.leading.equalTo(userNameLabel.snp.leading)
			make.bottom.equalToSuperview().inset(Metric.messageBubbleViewBottomMargin)
		}
	}
}

// MARK: - Viewable METHOD
extension ChatByFriendWithProfileImageCell: Viewable {
	func setupConfigures() {
		self.backgroundColor = AppTheme.Color.grey90
	}
	
	func setupViews() {
		self.addSubview(profileImageView)
		self.addSubview(userNameLabel)
		self.addSubview(messageBubbleView)
		messageBubbleView.addSubview(messageLabel)
		self.addSubview(timeLabel)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		profileImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.profileImageViewSize)
			make.top.equalToSuperview().inset(Metric.profileImageViewTopMargin)
			make.leading.equalToSuperview().inset(Metric.profileImageViewLeftMargin)
		}
		
		userNameLabel.snp.makeConstraints { make in
			make.top.equalTo(profileImageView.snp.top)
			make.leading.equalTo(profileImageView.snp.trailing).offset(Metric.userNameLabelLeftMargin)
		}
		
		messageBubbleView.snp.makeConstraints { make in
			guard let messageText = messageLabel.text else { return }
			let estimatedFrame = messageText.getEstimatedFrame(with: messageLabel.font)
			
			make.width.equalTo(estimatedFrame.width + Metric.messageBubbleViewAddWidthtMargin)
			make.height.equalTo(estimatedFrame.height + Metric.messageBubbleViewAddHeightMargin)
			make.top.equalTo(userNameLabel.snp.bottom).offset(Metric.messageBubbleViewTopMargin)
			make.leading.equalTo(userNameLabel.snp.leading)
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
