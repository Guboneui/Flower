//
//  ImageValueDescriptionStackView.swift
//  Profile
//
//  Created by 구본의 on 2024/03/01.
//

import UIKit

import ResourceKit
import UtilityKit

final class ImageValueDescriptionStackView: UIView {
	// MARK: - Metric
	private enum Metric {
		static let horizontalSpacing: CGFloat = 8.0
		static let verticalSpacing: CGFloat = 10.0
		static let imageViewSize: CGSize = .init(width: 16.0, height: 16.0)
	}
	
	// MARK: - UI Property
	private let imageView: UIImageView = UIImageView().then {
		$0.contentMode = .scaleAspectFit
	}
	
	private let valueLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Bold_16
		$0.textColor = AppTheme.Color.neutral900
	}
	
	private lazy var horizontalStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			imageView,
			valueLabel
		]
	).then {
		$0.axis = .horizontal
		$0.spacing = Metric.horizontalSpacing
		$0.alignment = .center
	}
	
	private let descriptionLabel: UILabel = UILabel().then {
		$0.font = AppTheme.Font.Medium_12
		$0.textColor = AppTheme.Color.neutral300
	}
	
	private lazy var verticalStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			horizontalStackView,
			descriptionLabel
		]
	).then {
		$0.axis = .vertical
		$0.spacing = Metric.horizontalSpacing
		$0.alignment = .center
	}
	
	// MARK: - Proeprty
	private let image: UIImage
	private let descriptionText: String
	
	// MARK: - Initialize
	init(
		image: UIImage,
		description: String
	) {
		self.image = image
		self.descriptionText = description
		super.init(frame: .zero)
		setupConfigures()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - PublicMethod
	func updateValue(with value: String) {
		valueLabel.text = value
	}
}

// MARK: - Viewable
extension ImageValueDescriptionStackView: Viewable {
	func setupConfigures() {
		backgroundColor = AppTheme.Color.neutral20
		imageView.image = image
		descriptionLabel.text = descriptionText
	}
	
	func setupViews() {
		addSubview(verticalStackView)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		imageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.imageViewSize)
		}
		
		verticalStackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func setupBinds() { }
}
