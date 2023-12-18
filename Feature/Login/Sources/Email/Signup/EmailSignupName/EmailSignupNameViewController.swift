//
//  EmailSignupNameViewController.swift
//  Login
//
//  Created by 김동겸 on 11/8/23.
//

import Foundation
import UIKit

import DesignSystem
import LoginData
import LoginDomain
import ResourceKit

import RxSwift
import SnapKit
import Then

public final class EmailSignupNameViewController: UIViewController {
	// MARK: - METRIC
	private enum Metric {
		static let profileViewBorderRadius: CGFloat = 54
		static let profileViewSize: CGFloat = 108
		static let profileViewTopMargin: CGFloat = 52
		
		static let profileImageViewSize: CGFloat = 48

		static let editProfileImageButtonRadius: CGFloat = 18
		static let editProfileImageButtonSize: CGFloat = 36

		static let cameraImageViewSize: CGSize = .init(width: 18, height: 18)

		static let nameViewHeightMargin: CGFloat = 73
		static let nameViewTopMargin: CGFloat = 60
		static let nameViewBothSidesMargin: CGFloat = 24
		
		static let nameTextFieldTopMargin: CGFloat = 8
		
		static let nextButtonBottomMargin: CGFloat = 34
		static let nextButttonBothsides: CGFloat = 24
	}
	
	// MARK: - FONT
	private enum Font {
		static let nameLabelFont: UIFont = AppTheme.Font.Bold_16
	}
	
	// MARK: - Image
	private enum Image {
		static let profileImage: UIImage = AppTheme.Image.profile
		static let cameraImage: UIImage = AppTheme.Image.camera
	}
	
	// MARK: - COLORSET
	private enum ColorSet {
		static let backgroundColor: UIColor = AppTheme.Color.white
		static let nameLabelColor: UIColor = AppTheme.Color.black
		static let profileViewBackgroundColor: UIColor = AppTheme.Color.white
		static let profileImageViewColor: UIColor = AppTheme.Color.grey40
		static let cameraViewBackgroundColor: UIColor = AppTheme.Color.primary
		static let cameraImageViewColor: UIColor = AppTheme.Color.white
	}
	
	// MARK: - TEXTSET
	private enum TextSet {
		static let navigationBarText: String = "회원가입"
		static let nameLabelText: String = "이름을 입력해 주세요"
		static let nextButtonText: String = "다음"
	}
	
	// MARK: - PRIVATE PROPERTY
	private let navigationBar = NavigationBar(.back, title: TextSet.navigationBarText)
	
	private let profileView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.profileViewBackgroundColor
		$0.makeCornerRadiusWithBorder(Metric.profileViewBorderRadius)
	}
	
	private let profileImageView: UIImageView = UIImageView().then {
		$0.image = Image.profileImage
		$0.tintColor = ColorSet.profileImageViewColor
	}
	
	private let editProfileImageButton: UIButton = UIButton(type: .system).then {
		let resizedImage: UIImage? = Image.cameraImage.changeImageSize(size: Metric.cameraImageViewSize)
		$0.tintColor = AppTheme.Color.white
		$0.setImage(resizedImage, for: .normal)
		$0.backgroundColor = ColorSet.cameraViewBackgroundColor
		$0.makeCornerRadius(Metric.editProfileImageButtonRadius)
	}
	
	private let nameView: UIView = UIView().then {
		$0.backgroundColor = ColorSet.backgroundColor
	}
	
	private let nameLabel: UILabel = UILabel().then {
		$0.text = TextSet.nameLabelText
		$0.font = Font.nameLabelFont
		$0.textColor = ColorSet.nameLabelColor
	}
	
	private let nameTextField: DefaultTextField = DefaultTextField(.name).then {
		$0.currentState = .normal
	}
	
	private let nextButton: DefaultButton = DefaultButton(title: TextSet.nextButtonText).then {
		$0.isEnabled = false
	}
	
	private var emailSignupNameViewModel: EmailSignupNameViewModelInterface

	private let disposeBag = DisposeBag()

	// MARK: - INITIALIZE
	public init(emailSignupNameViewModel: EmailSignupNameViewModelInterface) {
		self.emailSignupNameViewModel = emailSignupNameViewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - LIFE CYCLE
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupViews()
		setupGestures()
		setupBinding()
	}
}

// MARK: - PRIVATE METHOD
private extension EmailSignupNameViewController {
	func setupUI() {
		view.backgroundColor = ColorSet.backgroundColor
	}
	
	func setupViews() {
		view.addSubview(navigationBar)
		
		view.addSubview(profileView)
		profileView.addSubview(profileImageView)
		view.addSubview(editProfileImageButton)
		
		view.addSubview(nameView)
		nameView.addSubview(nameLabel)
		nameView.addSubview(nameTextField)
		
		view.addSubview(nextButton)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		navigationBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview()
		}
		
		profileView.snp.makeConstraints { make in
			make.size.equalTo(Metric.profileViewSize)
			make.top.equalTo(navigationBar.snp.bottom).offset(Metric.profileViewTopMargin)
			make.centerX.equalToSuperview()
		}
		
		profileImageView.snp.makeConstraints { make in
			make.size.equalTo(Metric.profileImageViewSize)
			make.centerX.centerY.equalToSuperview()
		}
		
		editProfileImageButton.snp.makeConstraints { make in
			make.size.equalTo(Metric.editProfileImageButtonSize)
			make.trailing.equalTo(profileView.snp.trailing)
			make.bottom.equalTo(profileView.snp.bottom)
		}
		
		nameView.snp.makeConstraints { make in
			make.height.equalTo(Metric.nameViewHeightMargin)
			make.top.equalTo(profileView.snp.bottom).offset(Metric.nameViewTopMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.nameViewBothSidesMargin)
		}
		
		nameLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
		}
		
		nameTextField.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(Metric.nameTextFieldTopMargin)
			make.horizontalEdges.equalToSuperview()
		}
		
		nextButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Metric.nextButtonBottomMargin)
			make.horizontalEdges.equalToSuperview().inset(Metric.nextButttonBothsides)
		}
	}
	
	func setupGestures() {
		navigationBar.rx.tapLeftButton
			.bind { [weak self] in
				guard let self else { return }
				
				if let navigation = self.navigationController as? EmailLoginNavigationController {
					navigation.pageController.moveToPrevPage()
					navigation.popViewController(animated: true)
				}
			}.disposed(by: disposeBag)

		nextButton.rx.touchHandler()
			.bind { [weak self] in
				guard let self else { return }
				
				if let navigation = self.navigationController as? EmailLoginNavigationController {
					navigation.pageController.moveToNextPage()
					
					let repository: UsersRepositoryInterface = UsersRepository()
					let useCase: UsersUseCaseInterface = UsersUseCase(usersRepository: repository)
					let name: String = emailSignupNameViewModel.nameRelay.value
					emailSignupNameViewModel.userSignupDTO.userName = name
					let viewModel: EmailSignupPhoneViewModel = EmailSignupPhoneViewModel(
						userSignupDTO: emailSignupNameViewModel.userSignupDTO,
						useCase: useCase
					)
					
					let signupPhoneVC = EmailSignupPhoneViewController(emailSignupPhoneViewModel: viewModel)
					navigation.pushViewController(signupPhoneVC, animated: true)
				}
			}.disposed(by: disposeBag)
		
		editProfileImageButton.rx.touchHandler()
			.bind {
				print("프로필 수정")
			}.disposed(by: disposeBag)
	}
	
	func setupBinding() {
		nameTextField.currentText
			.bind(onNext: { [weak self] nameText in
				guard let self else { return }
				
				self.emailSignupNameViewModel.nameRelay.accept(nameText)
				self.nextButton.isEnabled = !nameText.isEmpty
			}).disposed(by: disposeBag)
	}
}
