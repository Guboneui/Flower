//
//  MapCollectionViewCell.swift
//  Map
//
//  Created by 김민희 on 2024/01/03.
//

import UIKit

import DesignSystem
import ResourceKit
import UtilityKit

import SnapKit
import Then

class MapCollectionViewCell: UICollectionViewCell {
	private enum Metric {
		static let houseImageCornerRadius: CGFloat = 8
		static let houseImageViewSize: CGFloat = 108
		static let houseInfohorizontalEdgesMargin: CGFloat = 16
		static let houseSubTitleLabelTopMargin: CGFloat = 3
		static let rateViewTopMargin: CGFloat = 6
		static let rateImageViewSize: CGFloat = 16
		static let rateLabelLeftMargin: CGFloat = 2
		static let rateNumLabelLeftMargin: CGFloat = 2
		static let housePriceLabelBottomMargin: CGFloat = -16
		static let cellCornerRadius: CGFloat = 12
	}
	
	private enum TextSet {
		static let houseTitleLabelText: String = "게스트하우스 이름 게스트하우스 이름"
		static let houseSubTitleLabelText: String = "여기는 한줄소개가 나타나는 공간입니다. 여기는 한줄소개가 나타나는 공간입니다."
		static let rateLabelText: String = "4.5"
		static let rateNumLabelText: String = "후기 135개"
		static let housePriceLabelText: String = "80,000원 부터"
	}
	
	// MARK: - UI Property
	//TODO: 이미지뷰 사진 변경
	private let houseImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.camera
		$0.backgroundColor = .blue
		$0.makeCornerRadius(Metric.houseImageCornerRadius, edge: .all)
	}
	
	private let houseTitleLabel: UILabel = UILabel().then {
		$0.text = TextSet.houseTitleLabelText
		$0.textColor = AppTheme.Color.black
		$0.font = AppTheme.Font.Bold_14
	}
	
	private let houseSubTitleLabel: UILabel = UILabel().then {
		$0.text = TextSet.houseSubTitleLabelText
		$0.textColor = AppTheme.Color.grey40
		$0.font = AppTheme.Font.Regular_10
	}
	
	private let rateView: UIView = UIView()
	
	private let rateImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.rating
	}
	
	private let rateLabel: UILabel = UILabel().then {
		$0.text = TextSet.rateLabelText
		$0.textColor = AppTheme.Color.black
		$0.font = AppTheme.Font.Regular_12
		$0.setContentHuggingPriority(.required, for: .horizontal)
	}
	
	private let rateNumLabel: UILabel = UILabel().then {
		$0.text = TextSet.rateNumLabelText
		$0.textColor = AppTheme.Color.primary
		$0.font = AppTheme.Font.Regular_12
	}
	
	private let housePriceLabel: UILabel = UILabel().then {
		$0.text = TextSet.housePriceLabelText
		$0.textColor = AppTheme.Color.black
		$0.font = AppTheme.Font.Bold_16
		$0.textAlignment = .right
	}
	
	// MARK: - Iitialize
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConfigures()
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MapCollectionViewCell: Viewable {
	func setupConfigures() {
		backgroundColor = AppTheme.Color.white
		makeCornerRadius(Metric.cellCornerRadius, edge: .all)
	}
	
	func setupViews() {
		addSubview(houseImageView)
		addSubview(houseTitleLabel)
		addSubview(houseSubTitleLabel)
		addSubview(rateView)
		addSubview(housePriceLabel)
		
		rateView.addSubview(rateImageView)
		rateView.addSubview(rateLabel)
		rateView.addSubview(rateNumLabel)

		setupConstraints()
	}
	
	func setupConstraints() {
		houseImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.houseImageViewSize)
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(Metric.houseInfohorizontalEdgesMargin)
		}
		
		houseTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(houseImageView.snp.top)
			make.leading.equalTo(houseImageView.snp.trailing).offset(Metric.houseInfohorizontalEdgesMargin)
			make.trailing.equalToSuperview().offset(-Metric.houseInfohorizontalEdgesMargin)
		}
		
		houseSubTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(houseTitleLabel.snp.bottom).offset(Metric.houseSubTitleLabelTopMargin)
			make.leading.equalTo(houseImageView.snp.trailing).offset(Metric.houseInfohorizontalEdgesMargin)
			make.trailing.equalToSuperview().offset(-Metric.houseInfohorizontalEdgesMargin)
		}
		
		rateView.snp.makeConstraints { make in
			make.top.equalTo(houseSubTitleLabel.snp.bottom).offset(Metric.rateViewTopMargin)
			make.leading.equalTo(houseImageView.snp.trailing).offset(Metric.houseInfohorizontalEdgesMargin)
			make.trailing.equalToSuperview().offset(-Metric.houseInfohorizontalEdgesMargin)
			make.height.equalTo(Metric.rateImageViewSize)
		}
		
		rateImageView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
			make.size.equalTo(Metric.rateImageViewSize)
		}
		
		rateLabel.snp.makeConstraints { make in
			make.centerY.equalTo(rateImageView.snp.centerY)
			make.leading.equalTo(rateImageView.snp.trailing).offset(Metric.rateLabelLeftMargin)
		}
		
		rateNumLabel.snp.makeConstraints { make in
			make.centerY.equalTo(rateImageView.snp.centerY)
			make.leading.equalTo(rateLabel.snp.trailing).offset(Metric.rateNumLabelLeftMargin)
			make.trailing.equalToSuperview()
		}
		
		housePriceLabel.snp.makeConstraints { make in
			make.bottom.equalToSuperview().offset(Metric.housePriceLabelBottomMargin)
			make.trailing.equalToSuperview().offset(-Metric.houseInfohorizontalEdgesMargin)
			make.leading.equalTo(houseImageView.snp.trailing).offset(Metric.houseInfohorizontalEdgesMargin)
		}
	}
	
	func setupBinds() { }
}
