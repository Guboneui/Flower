//
//  PhoneNumberListCell.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/25.
//

import UIKit

import ResourceKit

import SnapKit
import Then

internal final class PhoneNumberListCell: UICollectionViewCell {
	
	// MARK: IDENTIFIER
  static let idendifier: String = "PhoneNumberListCell"
	
	// MARK: METRIC
	private enum Metric {
		static let phoneNumberLabelHorzontalMargin: CGFloat = 28
		static let phoneNumberLabelVerticalMargin: CGFloat = 18
	}
  
  private let phoneNumberLabel: UILabel = UILabel().then {
    $0.font = .AppFont.Bold_20
    $0.textColor = .AppColor.appBlack
    $0.textAlignment = .center
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupLayout()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    phoneNumberLabel.text = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - PUBLIC METHOD
  public func setupCellConfigure(number: String) {
    phoneNumberLabel.text = number
  }
}

// MARK: - PRIVATE METHOD
private extension PhoneNumberListCell {
  private func setupView() {
    contentView.backgroundColor = .AppColor.appSecondary
  }
  
  private func setupLayout() {
    contentView.addSubview(phoneNumberLabel)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    phoneNumberLabel.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Metric.phoneNumberLabelHorzontalMargin)
			make.verticalEdges.equalToSuperview().inset(Metric.phoneNumberLabelVerticalMargin)
    }
  }
}
