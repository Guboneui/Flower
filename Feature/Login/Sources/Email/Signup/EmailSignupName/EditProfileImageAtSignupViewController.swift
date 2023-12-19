//
//  EditProfileImageAtSignupViewController.swift
//  Login
//
//  Created by 구본의 on 2023/12/19.
//

import UIKit

import ResourceKit

import RxSwift
import SnapKit
import Then

final class EditProfileImageAtSignupViewController: UIViewController {
	
	// MARK: - Metric
	private enum Metric {
		static let navigationBarHeight: CGFloat = 54
		static let navigationBarButtonHorizontalMargin: CGFloat = 16
		static let navigationBarButtonCenterYMargin: CGFloat = -2
		static let backButtonSize: CGSize = .init(width: 24, height: 24)
		static let snapShotAreaHorizontalMargin: CGFloat = 36
		static let bottomContainerViewHeight: CGFloat = 56
		static let bottomButtonSize: CGSize = .init(width: 24, height: 24)
	}
	
	// MARK: - TextSet
	private enum TextSet {
		static let confirmButtonTitle: String = "완료"
	}
	
	// MARK: - UI Property
	private let snapShotAreaView: UIView = UIView().then {
		$0.backgroundColor = .clear
	}
	
	private let profileImageView: UIImageView = UIImageView().then {
		$0.backgroundColor = .green
	}
	
	private let blurView: UIVisualEffectView = .init()
	
	private let navigationBarView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.black.withAlphaComponent(0.7)
	}
	
	private let bottomContainerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.black.withAlphaComponent(0.7)
	}
	
	// MARK: - Property
	private let selectedImage: UIImage
	private let disposeBag: DisposeBag
	
	// MARK: - Initialize
	init(selectedImage: UIImage) {
		self.selectedImage = selectedImage
		self.disposeBag = .init()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupConfigures()
		setupViews()
		view.addSubview(blurView)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let maskView = UIView(frame: blurView.bounds)
//		maskView.clipsToBounds = true
//		maskView.backgroundColor = UIColor.clear
//		
//		let outerbezierPath = UIBezierPath.init(roundedRect: blurView.bounds, cornerRadius: 0)
//		let rect = CGRect(x: 150, y: 150, width: 100, height: 100)
//		let innerCirclepath = UIBezierPath.init(roundedRect: rect, cornerRadius: rect.height * 0.5)
//		outerbezierPath.append(innerCirclepath)
//		outerbezierPath.usesEvenOddFillRule = true
//		
//		let fillLayer = CAShapeLayer()
//		fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
//		fillLayer.fillColor = UIColor.green.cgColor
//		fillLayer.path = outerbezierPath.cgPath
//		maskView.layer.addSublayer(fillLayer)
//		
//		blurView.mask = maskView
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
//		setupSnapShotGuideLineLayer()
		
		blurView.frame = view.frame
		blurView.effect = UIBlurEffect(style: .dark)
		let maskView = UIView(frame: blurView.bounds)
		maskView.clipsToBounds = true
		maskView.backgroundColor = UIColor.clear
		
		let outerbezierPath = UIBezierPath.init(roundedRect: blurView.bounds, cornerRadius: 0)
		let snapShotFrame: CGRect = snapShotAreaView.frame
		let snapShotSize: CGSize = snapShotFrame.size
		let rect = CGRect(
			x: snapShotFrame.minX,
			y: snapShotFrame.minY,
			width: snapShotSize.width,
			height: snapShotSize.height
		)
		let innerCirclepath = UIBezierPath.init(roundedRect: rect, cornerRadius: rect.height * 0.5)
		outerbezierPath.append(innerCirclepath)
		outerbezierPath.usesEvenOddFillRule = true
		
		let fillLayer = CAShapeLayer()
		fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
		fillLayer.fillColor = UIColor.green.cgColor
		fillLayer.path = outerbezierPath.cgPath
		maskView.layer.addSublayer(fillLayer)
		
		blurView.mask = maskView
		
		
		
		
//		let maskLayer = CAShapeLayer()
//		maskLayer.frame = self.view.bounds
//		maskLayer.fillColor = AppTheme.Color.black.withAlphaComponent(0.3).cgColor
//		let path = UIBezierPath(
//			roundedRect: rect,
//			cornerRadius: snapShotSize.width / 2.0
//		)
//		path.append(UIBezierPath(rect: view.bounds))
//		maskLayer.path = path.cgPath
//		maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
//		view.layer.addSublayer(maskLayer)
//		
		
		
		
		
		
		
		
		
		
		
		
		view.bringSubviewToFront(navigationBarView)
		view.bringSubviewToFront(bottomContainerView)
	}
}

// MARK: - Private Extension
private extension EditProfileImageAtSignupViewController {
	func setupConfigures() {
		view.backgroundColor = AppTheme.Color.black
		profileImageView.image = selectedImage
	}
	
	func setupViews() {
		view.addSubview(snapShotAreaView)
		snapShotAreaView.addSubview(profileImageView)
		setupConstraints()
		setNavigationBar()
		setBottomContainerView()
		setGuideAreaViews()
	}
	
	func setupConstraints() {
		snapShotAreaView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Metric.snapShotAreaHorizontalMargin)
			make.height.equalTo(snapShotAreaView.snp.width)
			make.centerY.equalToSuperview()
		}
		
		profileImageView.snp.makeConstraints { make in
			make.edges.equalTo(view.safeAreaLayoutGuide)
		}
		view.layoutIfNeeded()
	}
	
	func setupSnapShotGuideLineLayer() {
		let snapShotFrame: CGRect = snapShotAreaView.frame
		let snapShotSize: CGSize = snapShotFrame.size
		let rect = CGRect(
			x: snapShotFrame.minX,
			y: snapShotFrame.minY,
			width: snapShotSize.width,
			height: snapShotSize.height
		)
		let maskLayer = CAShapeLayer()
		maskLayer.frame = self.view.bounds
		maskLayer.fillColor = AppTheme.Color.black.withAlphaComponent(0.3).cgColor
		let path = UIBezierPath(
			roundedRect: rect,
			cornerRadius: snapShotSize.width / 2.0
		)
		path.append(UIBezierPath(rect: view.bounds))
		maskLayer.path = path.cgPath
		maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
		view.layer.addSublayer(maskLayer)
	}
}

// MARK: - CustomViewComponents
private extension EditProfileImageAtSignupViewController {
	func setNavigationBar() {
		let backButton: UIButton = UIButton(type: .system).then {
			$0.setImage(AppTheme.Image.arrowLeft, for: .normal)
			$0.tintColor = AppTheme.Color.white
		}
		
		let confirmButton: UIButton = UIButton(type: .system).then {
			$0.setTitle("완료", for: .normal)
			$0.titleLabel?.font = AppTheme.Font.Bold_18
			$0.tintColor = AppTheme.Color.primary
		}
		
		navigationBarView.addSubview(backButton)
		navigationBarView.addSubview(confirmButton)
		view.addSubview(navigationBarView)

		navigationBarView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(Metric.navigationBarHeight)
		}
		
		backButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(Metric.navigationBarButtonHorizontalMargin)
			make.size.equalTo(Metric.backButtonSize)
			make.centerY.equalToSuperview().offset(Metric.navigationBarButtonCenterYMargin)
		}
		
		confirmButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().offset(-Metric.navigationBarButtonHorizontalMargin)
			make.centerY.equalTo(backButton.snp.centerY)
		}
		
		setNavigationBarGestures(
			leftButton: backButton,
			rightButton: confirmButton
		)
	}
	
	func setNavigationBarGestures(
		leftButton: UIButton,
		rightButton: UIButton
	) {
		leftButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				self.dismiss(animated: true)
			}.disposed(by: disposeBag)
		
		rightButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				self.dismiss(animated: true)
			}.disposed(by: disposeBag)
	}
	
	func setBottomContainerView() {
		let rotateLeftButton: UIButton = UIButton(type: .system).then {
			$0.tintColor = AppTheme.Color.white
			$0.setImage(AppTheme.Image.rotateLeft, for: .normal)
		}
		
		let rotatePIButton: UIButton = UIButton(type: .system).then {
			$0.tintColor = AppTheme.Color.white
			$0.setImage(AppTheme.Image.rotatePI, for: .normal)
		}
		
		let rotateRightButton: UIButton = UIButton(type: .system).then {
			$0.tintColor = AppTheme.Color.white
			$0.setImage(AppTheme.Image.rotateRight, for: .normal)
		}
		
		let buttonStackView: UIStackView = .init(arrangedSubviews: [
			rotateLeftButton,
			rotatePIButton,
			rotateRightButton
		]).then {
			$0.distribution = .equalSpacing
			$0.axis = .horizontal
		}
		
		bottomContainerView.addSubview(buttonStackView)
		view.addSubview(bottomContainerView)
		
		bottomContainerView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(Metric.bottomContainerViewHeight)
			make.bottom.equalTo(view.safeAreaLayoutGuide)
		}
		
		buttonStackView.subviews.forEach { button in
			button.snp.makeConstraints { make in
				make.size.equalTo(Metric.bottomButtonSize)
			}
		}
		
		buttonStackView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(86)
			make.top.equalToSuperview().offset(8)
			make.bottom.equalToSuperview().offset(-24)
		}
	}
	
	func setGuideAreaViews() {
		let topGuideAreaView: UIView = UIView().then {
			$0.backgroundColor = AppTheme.Color.black
		}
		
		let bottomGuideAreaView: UIView = UIView().then {
			$0.backgroundColor = AppTheme.Color.black
		}
		
		view.addSubview(topGuideAreaView)
		view.addSubview(bottomGuideAreaView)
		
		topGuideAreaView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(21)
		}
		
		bottomGuideAreaView.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(30)
		}
	}
}
