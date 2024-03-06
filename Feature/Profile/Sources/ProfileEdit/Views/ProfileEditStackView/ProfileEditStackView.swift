//
//  ProfileEditStackView.swift
//  Profile
//
//  Created by 구본의 on 2024/03/07.
//

import UIKit

import ResourceKit
import UtilityKit

import SnapKit
import Then

final class ProfileEditStackView: UIView {
	// MARK: Metric
	private enum Metric {
		static let titleLabelWidth: CGFloat = 64.0
		static let spacingAfterTitle: CGFloat = 28.0
		static let spacingAfterContents: CGFloat = 8.0
		static let editButtonWidth: CGFloat = 42.0
		static let imageViewSize: CGSize = .init(width: 16.0, height: 16.0)
		static let imageViewRadius: CGFloat = 8.0
		static let horizontalMargin: CGFloat = 24.0
		static let verticalMargin: CGFloat = 18.0
		static let height: CGFloat = 17.0
	}
	
	// MARK: - TextSet
	private enum TextSet {
		static let editButtonTitle: String = "수정하기"
	}
	// MARK: - UI Property
	private let titleLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Medium_14
		$0.textColor = AppTheme.Color.grey40
	}
	
	private let contentsLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Medium_14
		$0.textColor = AppTheme.Color.black
		$0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
	}
	
	private let imageView: UIImageView = UIImageView().then {
		$0.contentMode = .scaleAspectFit
		$0.makeCornerRadius(Metric.imageViewRadius)
	}
	
	private let editButton: UIButton = UIButton(type: .system).then {
		$0.setTitle(TextSet.editButtonTitle, for: .normal)
		$0.titleLabel?.font = AppTheme.Font.Medium_12
		$0.tintColor = AppTheme.Color.primary
	}
	
	private let spacer: UIView = UIView()
	
	private lazy var stackView: UIStackView = UIStackView(
		arrangedSubviews: [
			titleLabel,
			contentsLabel,
			imageView,
			spacer,
			editButton
		]
	).then {
		$0.axis = .horizontal
		$0.alignment = .center
		$0.setCustomSpacing(Metric.spacingAfterTitle, after: titleLabel)
		$0.setCustomSpacing(Metric.spacingAfterContents, after: contentsLabel)
		$0.setCustomSpacing(.zero, after: imageView)
		$0.setCustomSpacing(.zero, after: spacer)
	}

	// MARK: - Property
	
	// MARK: - Initialize
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public Method
	public func updateConfigure(with viewModel: ProfileEditStackViewModel) {
		titleLabel.text = viewModel.title
		contentsLabel.text = viewModel.contents
		if let image = viewModel.image {
			imageView.image = image
			imageView.isHidden = false
		} else {
			imageView.isHidden = true
		}
		editButton.isHidden = !viewModel.isEditable
	}
}

// MARK: - Viewable
extension ProfileEditStackView: Viewable {
	func setupConfigures() {
		backgroundColor = AppTheme.Color.white
	}
	
	func setupViews() {
		addSubview(stackView)
		setupConstraints()
	}
	
	func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.width.equalTo(Metric.titleLabelWidth)
		}
		
		imageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.imageViewSize)
		}
		
		editButton.snp.makeConstraints { make in
			make.width.equalTo(Metric.editButtonWidth)
		}
		
		stackView.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview().inset(Metric.verticalMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.horizontalMargin)
			make.height.equalTo(Metric.height)
		}
	}
	
	func setupBinds() { }
}
