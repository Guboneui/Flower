//
//  PageController.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/23.
//

import UIKit

import ResourceKit

import SnapKit
import Then

/// 위치를 View의 centerY로 잡기때문에, 반드시 높이를 지정 해줘야 합니다.
public class PageController: UIView {
  
  // MARK: - PROPERTY
  private let pageCount: Int
  private let selectedColor: UIColor
  private let defaultColor: UIColor
  private let spacing: CGFloat
  private let defaultControllerSize: CGSize
  private let selectedControllerSize: CGSize
  private let durationTime: TimeInterval
  
  private var currentPage: Int = 0
  private var pageControllerCollection: [UIView] = []
  
  private let pageControllerStackView: UIStackView = UIStackView()
  private let progressBar: UIView = UIView()
  
  // MARK: - INITIALIZE
  public init(
    pageCount: Int,
    selectedColor: UIColor = .AppColor.appPrimary,
    defaultColor: UIColor = .AppColor.appGrey70,
    defaultControllerSize: CGSize,
    selectedControllerHeight: CGFloat,
    durationTime: TimeInterval = 0.35
  ) {
    self.pageCount = pageCount
    self.selectedColor = selectedColor
    self.defaultColor = defaultColor
    self.spacing = defaultControllerSize.width
    self.defaultControllerSize = defaultControllerSize
    self.selectedControllerSize = .init(
      width: defaultControllerSize.width * 3, 
      height: selectedControllerHeight
    )
    self.durationTime = durationTime
    super.init(frame: .zero)
    setupConfigure()
    setupViews()
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - PUBLIC METHOD
  
  /// 외부에서 다음 페이지로 넘어가기 위해 사용됩니다.
  public func moveToNextPage() {
    UIView.animate(
      withDuration: durationTime,
      animations: {
        if self.currentPage < self.pageCount - 1 {
          self.currentPage += 1
          self.progressBar.snp.remakeConstraints { make in
            make.leading.equalTo(self.pageControllerCollection[self.currentPage].snp.leading)
            make.centerY.equalTo(self.pageControllerStackView.snp.centerY)
            make.size.equalTo(self.selectedControllerSize)
          }
          
          self.pageControllerCollection[self.currentPage-1].backgroundColor = self.defaultColor
          self.pageControllerCollection[self.currentPage].backgroundColor = .clear

          self.layoutIfNeeded()
        }
      }
    )
  }
	
	/// 외부에서 이전 페이지로 넘어가기 위해 사용됩니다.
	public func moveToPrevPage() {
		UIView.animate(
			withDuration: durationTime,
			animations: {
				if self.currentPage > 0 {
					self.currentPage -= 1
					self.progressBar.snp.remakeConstraints { make in
						make.leading.equalTo(self.pageControllerCollection[self.currentPage].snp.leading)
						make.centerY.equalTo(self.pageControllerStackView.snp.centerY)
						make.size.equalTo(self.selectedControllerSize)
					}
					
					self.pageControllerCollection[self.currentPage+1].backgroundColor = self.defaultColor
					self.pageControllerCollection[self.currentPage].backgroundColor = .clear

					self.layoutIfNeeded()
				}
			}
		)
	}
  
  /// 외부에서 첫 페이지로 넘어가기 위해 사용됩니다.
  public func moveToFirstPage() {
    UIView.animate(
      withDuration: durationTime,
      animations: {
        self.currentPage = 0
        self.progressBar.snp.remakeConstraints { make in
          make.leading.equalTo(self.pageControllerCollection[self.currentPage].snp.leading)
          make.centerY.equalTo(self.pageControllerStackView.snp.centerY)
          make.size.equalTo(self.selectedControllerSize)
        }
        self.layoutIfNeeded()
      }
    )
    
    pageControllerCollection.forEach { $0.backgroundColor = defaultColor }
  }
}

// MARK: - PRIVATE METHOD
private extension PageController {
  func setupConfigure() {
    progressBar.backgroundColor = selectedColor
    progressBar.makeCornerRadius(selectedControllerSize.height / 2)
    
    pageControllerStackView.axis = .horizontal
    pageControllerStackView.spacing = spacing
  }
  
  func makeBasePageController() {
    for index in 0..<pageCount+1 {
      let pageController = UIView()
      pageController.backgroundColor = index == 0 ? .clear : defaultColor
      pageController.makeCornerRadius(defaultControllerSize.height / 2)
      pageController.snp.makeConstraints { make in
        make.size.equalTo(defaultControllerSize)
      }
      
      pageControllerCollection.append(pageController)
      pageControllerStackView.addArrangedSubview(pageController)
    }
  }
  
  func setupViews() {
    makeBasePageController()
    
    addSubview(pageControllerStackView)
    addSubview(progressBar)
    
    setupConstraints()
  }
  
  func setupConstraints() {
    pageControllerStackView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.horizontalEdges.equalToSuperview()
    }
    
    progressBar.snp.makeConstraints { make in
      make.leading.equalTo(pageControllerCollection[currentPage].snp.leading)
      make.centerY.equalTo(pageControllerStackView.snp.centerY)
      make.size.equalTo(selectedControllerSize)
    }
  }
}
