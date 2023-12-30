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
		static let buttonStackViewHorizontalMargin: CGFloat = 86
		static let buttonStackViewTopMargin: CGFloat = 8
		static let buttonStackViewBottomMargin: CGFloat = -24
		
		static let maxScale: CGFloat = 3.0
		static let minScale: CGFloat = 1.0
	}
	
	// MARK: - TextSet
	private enum TextSet {
		static let confirmButtonTitle: String = "완료"
	}
	
	// MARK: - UI Property
	private let navigationBarView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.black.withAlphaComponent(0.7)
	}
	
	private let profileImageView: UIImageView = UIImageView().then {
		$0.backgroundColor = AppTheme.Color.black
		$0.contentMode = .scaleAspectFit
	}
	
	private let snapShotAreaView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.black
	}
	
	private let blurView: UIVisualEffectView = UIVisualEffectView().then {
		$0.effect = UIBlurEffect(style: .dark)
		$0.backgroundColor = UIColor.clear
	}
	
	private let bottomContainerView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.black.withAlphaComponent(0.7)
	}
	
	private let topGuideAreaView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.black.withAlphaComponent(0.7)
	}
	
	private let bottomGuideAreaView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.black.withAlphaComponent(0.7)
	}
	
	// MARK: - Property
	private let selectedImage: UIImage
	private let disposeBag: DisposeBag
	private var imageViewScale: CGFloat
	private var toggle: Bool = true
	
	// MARK: - Initialize
	init(selectedImage: UIImage) {
		self.selectedImage = selectedImage
		self.disposeBag = .init()
		self.imageViewScale = 1.0
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
		setupImagePinchGesture()
		setupImagePanGesture()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupSnapShotGuideLineLayer()
		view.bringSubviewToFront(navigationBarView)
		view.bringSubviewToFront(bottomContainerView)
		view.bringSubviewToFront(topGuideAreaView)
		view.bringSubviewToFront(bottomGuideAreaView)
		
		setupSnapShowGuideLineBlurLayer()
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
		profileImageView.addSubview(blurView)
		
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
		
		blurView.snp.makeConstraints { make in
			make.edges.equalTo(view.snp.edges)
		}
		
		view.layoutIfNeeded()
	}
	
	func setupSnapShotGuideLineLayer() {
		let snapShotFrame: CGRect = snapShotAreaView.frame
		let snapShotSize: CGSize = snapShotFrame.size
		let maskLayer = CAShapeLayer()
		maskLayer.frame = self.profileImageView.bounds
		maskLayer.fillColor = AppTheme.Color.black.withAlphaComponent(0.3).cgColor
		let path = UIBezierPath(
			roundedRect: snapShotFrame,
			cornerRadius: snapShotSize.width / 2.0
		)
		path.append(UIBezierPath(rect: view.bounds))
		maskLayer.path = path.cgPath
		maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
		view.layer.addSublayer(maskLayer)
	}
	
	func setupSnapShowGuideLineBlurLayer() {
		let maskView = UIView(frame: view.bounds)
		maskView.clipsToBounds = true
		maskView.backgroundColor = UIColor.clear
		
		let outerbezierPath = UIBezierPath.init(
			roundedRect: view.bounds,
			cornerRadius: .zero
		)
		let snapShotFrame: CGRect = snapShotAreaView.frame
		let snapShotSize: CGSize = snapShotFrame.size
		let innerCirclepath = UIBezierPath.init(
			roundedRect: snapShotFrame,
			cornerRadius: snapShotSize.width / 2.0
		)
		outerbezierPath.append(innerCirclepath)
		outerbezierPath.usesEvenOddFillRule = true
		
		let fillLayer = CAShapeLayer()
		fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
		fillLayer.fillColor = AppTheme.Color.black.cgColor
		fillLayer.path = outerbezierPath.cgPath
		maskView.layer.addSublayer(fillLayer)
		
		blurView.mask = maskView
	}
	
	func setGuideAreaViews() {
		view.addSubview(topGuideAreaView)
		view.addSubview(bottomGuideAreaView)
		
		topGuideAreaView.snp.makeConstraints { make in
			make.top.equalTo(view.snp.top)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
		}
		
		bottomGuideAreaView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(view.snp.bottom)
		}
	}
	
	private func setupImagePinchGesture() {
		profileImageView.rx.pinchGesture()
			.when(.began, .changed, .ended)
			.share(replay: 1)
			.subscribe(onNext: { [weak self] recognize in
				guard let self = self else { return }
				switch recognize.state {
				case .began: self.blurView.effect = nil
				case .changed:
					let pinchScale: CGFloat = recognize.scale
					if self.imageViewScale * pinchScale < Metric.maxScale &&
						 self.imageViewScale * pinchScale > Metric.minScale {
						self.imageViewScale *= pinchScale
						self.profileImageView.transform = self.profileImageView.transform.scaledBy(
							x: pinchScale,
							y: pinchScale
						)
					}
					recognize.scale = 1.0
				case .ended:
					self.blurView.effect = UIBlurEffect(style: .dark)
				default: break
				}
			}).disposed(by: disposeBag)
	}
	
	private func setupImagePanGesture() {
		var imageCenterOffset: CGPoint = .zero
		profileImageView.rx.panGesture()
			.when(.began, .changed, .ended)
			.share(replay: 1)
			.subscribe(onNext: { [weak self] recognize in
				guard let self = self else { return }
				switch recognize.state {
				case .began:
					imageCenterOffset = CGPoint(
						x: self.profileImageView.center.x,
						y: self.profileImageView.center.y
					)
					self.blurView.effect = nil
				case .changed:
					let translation = recognize.translation(in: self.profileImageView)
					self.profileImageView.center = CGPoint(
						x: imageCenterOffset.x + translation.x,
						y: imageCenterOffset.y + translation.y
					)
				case .ended:
					imageCenterOffset = .zero
					self.blurView.effect = UIBlurEffect(style: .dark)
				default: break
				}
			}).disposed(by: disposeBag)
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
			$0.setTitle(TextSet.confirmButtonTitle, for: .normal)
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
			make.horizontalEdges.equalToSuperview()
				.inset(Metric.buttonStackViewHorizontalMargin)
			make.top.equalToSuperview()
				.offset(Metric.buttonStackViewTopMargin)
			make.bottom.equalToSuperview()
				.offset(Metric.buttonStackViewBottomMargin)
		}
	}
}
