//
//  DimModalPresentable.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/22.
//

import UIKit

import ResourceKit

import SnapKit
import Then

public protocol DimModalPresentable {
  var parentVC: UIViewController? { get set }
  
  var backgroundView: UIView { get }
  var modalView: UIView { get }
  
  func showModal(_ completion: (() -> Void)?)
  func hideModal(_ completion: (() -> Void)?)
}

public extension DimModalPresentable where Self: UIViewController {
  
  /// 모달을 나타나게 합니다.
  /// - parameter completion: 나타난 후 필요한 액션이 있다면 정의합니다.
  func showModal(_ completion: (() -> Void)? = nil) {
    guard let parentVC else { return }
    setupInitialConfigure()
    setupInitialLayout(parentVC: parentVC)
    animateToShowUp(parentVC: parentVC, completion)
  }
  
  /// 모달을 사라지게 합니다.
  /// - parameter completion: 사라진 후 필요한 액션이 있다면 정의합니다.
  func hideModal(_ completion: (() -> Void)? = nil) {
    guard let parentVC  else { return }
    animateToHideDown(parentVC: parentVC, completion)
  }
}

private extension DimModalPresentable where Self: UIViewController {
  
  // MARK: - PROPERTY
  
  var showAnimationDurationTime: TimeInterval { 0.5 }
  var hideAnimationDurationTime: TimeInterval { 0.5 }
  
  var backgroundViewColor: UIColor { .black.withAlphaComponent(0.3) }
	var modalViewColor: UIColor { AppTheme.Color.white }
  var modalViewRadius: CGFloat { 20.0 }
  
  // MARK: - METHOD
  
  /// 공통 View의 속성을 정의합니다.
  func setupInitialConfigure() {
    backgroundView.alpha = 0.0
    backgroundView.backgroundColor = backgroundViewColor
    
    modalView.alpha = 0.3
    modalView.backgroundColor = modalViewColor
    modalView.makeCornerRadius(modalViewRadius, edge: .onlyTop)
  }
  
  /// 공통 View의 기본 레이아웃을 정의합니다.
  func setupInitialLayout(parentVC: UIViewController) {
    parentVC.addChild(self)
    self.didMove(toParent: parentVC)
    
    parentVC.view.addSubview(self.view)
    
    self.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    self.view.addSubview(backgroundView)
    self.view.addSubview(modalView)
    
    backgroundView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    modalView.snp.makeConstraints { make in
      make.top.equalTo(view.snp.bottom)
      make.horizontalEdges.equalToSuperview()
    }
    
    self.view.layoutIfNeeded()
  }
  
  /// 모달이 올라올 때 애니메이션을 정의합니다.
  func animateToShowUp(
    parentVC: UIViewController,
    _ completion: (() -> Void)?
  ) {
    UIView.animate(
      withDuration: showAnimationDurationTime,
      delay: 0.0,
      options: .curveEaseOut,
      animations: {
        self.backgroundView.alpha = 1.0
        self.modalView.alpha = 1.0
        self.modalView.snp.remakeConstraints { make in
          make.bottom.equalToSuperview()
          make.horizontalEdges.equalToSuperview()
        }
        self.view.layoutIfNeeded()
      }, completion: { _ in
        completion?()
      }
    )
  }
  
  /// 모달이 사라질 때 애니메이션을 정의합니다.
  func animateToHideDown(
    parentVC: UIViewController,
    _ completion: (() -> Void)?
  ) {
    UIView.animate(
      withDuration: hideAnimationDurationTime,
      delay: 0.0,
      options: .curveEaseOut,
      animations: {
        self.view.alpha = 0.0
        self.modalView.snp.remakeConstraints { make in
          make.top.equalTo(self.view.snp.bottom)
          make.horizontalEdges.equalToSuperview()
        }
        self.view.layoutIfNeeded()
      }, completion: { [weak self] _ in
        self?.view.removeFromSuperview()
        self?.removeFromParent()
        completion?()
      }
    )
  }
}
