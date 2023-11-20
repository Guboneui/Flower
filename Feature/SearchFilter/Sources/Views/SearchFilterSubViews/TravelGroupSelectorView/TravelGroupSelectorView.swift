//
//  TravelGroupSelectorView.swift
//  SearchFilter
//
//  Created by 구본의 on 2023/11/19.
//

import UIKit

import DesignSystem
import ResourceKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class TravelGroupSelectorView: UIView {
	
	// MARK: - METRIC
	private enum Metric {
		static let radius: CGFloat = 22
		static let stackViewSpacing: CGFloat = 24
		static let stackViewTopMargin: CGFloat = 24
		static let stackViewHorizontalMargin: CGFloat = 24
		
		static let subViewHorizontalMargin: CGFloat = 24
		static let locationContainerViewHeight: CGFloat = 50
		static let searchImageSize: CGFloat = 18
		static let searchLabelLeftMargin: CGFloat = 8
		
		static let popularSpotCollectionViewTopMargin: CGFloat = 8
		static let popularSpotCollectionViewBottomMargin: CGFloat = -30
		static let popularSpotCollectionViewHeight: CGFloat = 56
	}
	
	// MARK: - UI PROPERTY
	private let titleLabel: UILabel = UILabel().then {
		$0.text = "마지막입니다"
		$0.font = AppTheme.Font.Bold_20
		$0.textColor = AppTheme.Color.black
	}
	
	private let groupLabel: UILabel = UILabel().then {
		$0.text = "인원"
		$0.font = AppTheme.Font.Bold_14
		$0.textColor = AppTheme.Color.black
	}
	
	private let minusButton: UIButton = UIButton().then {
		let resizedImage = AppTheme.Image.minusDiable.changeImageSize(
			size: .init(
				width: 28,
				height: 28
			)
		)
		$0.setImage(resizedImage, for: .normal)
	}
	
	private let selectingGroupCountLabel: UILabel = UILabel().then {
		$0.text = "0"
		$0.font = AppTheme.Font.Bold_16
		$0.textColor = AppTheme.Color.black
	}
	
	private let plusButton: UIButton = UIButton().then {
		let resizedImage = AppTheme.Image.plusEnable.changeImageSize(
			size: .init(
				width: 28,
				height: 28
			)
		)
		$0.setImage(resizedImage, for: .normal)
	}
	
	private lazy var groupCountingStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			minusButton,
			selectingGroupCountLabel,
			plusButton
		]).then {
			$0.spacing = 8
			$0.axis = .horizontal
		}
	
	private let disposeBag: DisposeBag = .init()
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigure()
		setupSubViews()
		setupGestures()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - PRIVATE METHOD
private extension TravelGroupSelectorView {
	func setupConfigure() {
		backgroundColor = AppTheme.Color.white
		makeCornerRadiusWithBorder(Metric.radius)
		
		self.layer.masksToBounds = false
		self.layer.shadowColor = AppTheme.Color.black.withAlphaComponent(0.1).cgColor
		self.layer.shadowOpacity = 1.0
		self.layer.shadowRadius = 20
		self.layer.shadowOffset = .init(width: 0, height: 2)
	}
	
	func setupSubViews() {
		addSubview(titleLabel)
		addSubview(groupLabel)
		addSubview(groupCountingStackView)
		setupConstraints()
	}
	
	func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(24)
			make.horizontalEdges.equalToSuperview().inset(22)
		}
		
		groupLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(21.5)
			make.leading.equalToSuperview().offset(28)
			make.bottom.equalToSuperview().offset(-33.5)
		}
		
		minusButton.snp.makeConstraints { make in
			make.size.equalTo(36)
		}
		
		plusButton.snp.makeConstraints { make in
			make.size.equalTo(36)
		}
		
		groupCountingStackView.snp.makeConstraints { make in
			make.centerY.equalTo(groupLabel.snp.centerY)
			make.trailing.equalToSuperview().offset(-24)
		}
	}
	
	func setupGestures() {
		minusButton.rx.touchHandler()
			.bind {
				print("MINUS")
			}.disposed(by: disposeBag)
		
		plusButton.rx.touchHandler()
			.bind {
				print("PLUS")
			}.disposed(by: disposeBag)
	}
}
