//
//  PhoneNumberInputView.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/24.
//

import UIKit

import ResourceKit

import RxGesture
import RxRelay
import RxSwift
import SnapKit
import Then

public class PhoneNumberInputView: UIView {
	
	// MARK: - OUTPUT
	/// 사용자의 번호가 모두 입력되었는지를 검증합니다.
	/// middle, last number가 4자리 입력되었다면 true, 아닐 경우에는 false를 리턴합니다.
	/// 버튼의 isEnable 값과 사용하면 좋습니다.
	public var isPhoneNumberComplete: Observable<Bool>!
	
	// MARK: - METRIC
	private enum Metric {
		static let firstNumberDropdownButtonLeftInset: CGFloat = 16
		static let firstNumberDropdownButtonRightInset: CGFloat = 16
		static let dropDownImageSize: CGSize = CGSize(width: 24, height: 24)
		static let dropDownImageRightMargin: CGFloat = -12
		static let textFieldHorizontalMargin: CGFloat = 28
		static let textFieldVerticalMargin: CGFloat = 18
	}
	
	private let firstNumberBaseView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.secondary
		$0.makeCornerRadius(20)
	}
	
	private let firstNumberDropdownButton: UIButton = UIButton(primaryAction: nil).then {
		$0.titleLabel?.font = AppTheme.Font.Bold_20
		$0.titleLabel?.textAlignment = .left
		$0.tintColor = AppTheme.Color.black
		$0.showsMenuAsPrimaryAction = true
		$0.changesSelectionAsPrimaryAction = true
		$0.contentEdgeInsets = .init(
			top: 0, left: Metric.firstNumberDropdownButtonLeftInset,
			bottom: 0, right: Metric.firstNumberDropdownButtonRightInset * 2
		)
	}
	
	private let dropDownImageView: UIImageView = UIImageView().then {
		$0.image = AppTheme.Image.dropDown
		$0.contentMode = .scaleAspectFit
	}
	
	private let middleNumberBaseView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.secondary
		$0.makeCornerRadius(20)
	}
	
	private let middleNumberTextField: UITextField = UITextField().then {
		$0.font = AppTheme.Font.Bold_20
		$0.textColor = AppTheme.Color.black
		$0.textAlignment = .center
		$0.keyboardType = .numberPad
	}
	
	private let lastNumberBaseView: UIView = UIView().then {
		$0.backgroundColor = AppTheme.Color.secondary
		$0.makeCornerRadius(20)
	}
	
	private let lastNumberTextField: UITextField = UITextField().then {
		$0.font = AppTheme.Font.Bold_20
		$0.textColor = AppTheme.Color.black
		$0.textAlignment = .center
		$0.keyboardType = .numberPad
	}
	
	private lazy var phoneNumberInputStackView: UIStackView = UIStackView(
		arrangedSubviews: [
			firstNumberBaseView,
			middleNumberBaseView,
			lastNumberBaseView
		]
	).then {
		$0.axis = .horizontal
		$0.spacing = 8
		$0.distribution = .fillEqually
	}
	
	private let viewModel: PhoneNumberInputViewModel
	private let disposeBag: DisposeBag
	
	// MARK: - INITIALIZE
	
	/// firstNumber가 될 수 있는 배열을 생성자에서 받습니다.
	public init(with firstPhoneNumbers: [String]) {
		self.disposeBag = .init()
		self.viewModel = PhoneNumberInputViewModelImpl()
		super.init(frame: .zero)
		viewModel.phoneNumbers.accept(firstPhoneNumbers)
		setupSubViews()
		setupBindings()
		setupDropdownMenuButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - PUBLIC METHOD
	/// middleNumberTextField로 시점을 이동시킵니다.
	public func focusToMiddleNumberTextField() {
		middleNumberTextField.becomeFirstResponder()
	}
	
	/// lastNumberTextField로 시점을 이동시킵니다.
	public func focusToLastNumberTextField() {
		lastNumberTextField.becomeFirstResponder()
	}
	
	/// 입력된 번호를 옵셔널 Tuple 형태로 제공받습니다.
	public func getUserPhoneNumber() -> PhoneNumber? {
		if let first = firstNumberDropdownButton.currentTitle,
			 let middle = middleNumberTextField.text,
			 let last = lastNumberTextField.text {
			
			let phoneNumber: PhoneNumber = .init(
				first: first,
				middle: middle,
				last: last
			)
			
			return phoneNumber
		}
		return nil
	}
}

// MARK: - Private Method WITH LAYOUT
private extension PhoneNumberInputView {
	func setupSubViews() {
		firstNumberBaseView.addSubview(firstNumberDropdownButton)
		firstNumberBaseView.addSubview(dropDownImageView)
		
		middleNumberBaseView.addSubview(middleNumberTextField)
		lastNumberBaseView.addSubview(lastNumberTextField)
		
		addSubview(phoneNumberInputStackView)
		setupConstraints()
	}
	
	func setupConstraints() {
		firstNumberDropdownButton.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.verticalEdges.equalToSuperview()
		}
		
		dropDownImageView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().offset(Metric.dropDownImageRightMargin)
			make.size.equalTo(Metric.dropDownImageSize)
		}
		
		middleNumberTextField.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Metric.textFieldHorizontalMargin)
			make.verticalEdges.equalToSuperview().inset(Metric.textFieldVerticalMargin)
		}
		
		lastNumberTextField.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Metric.textFieldHorizontalMargin)
			make.verticalEdges.equalToSuperview().inset(Metric.textFieldVerticalMargin)
		}
		
		phoneNumberInputStackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}

// MARK: - PRIVAET METHOD
private extension PhoneNumberInputView {
	
	func setupBindings() {
		isPhoneNumberComplete = Observable.combineLatest(
			middleNumberTextField.rx.text.orEmpty.map { $0.count == 4 },
			lastNumberTextField.rx.text.orEmpty.map { $0.count == 4 }
		) { $0 && $1 }
		
		middleNumberTextField.rx.text.orEmpty
			.map { String($0.prefix(4)) }
			.bind(to: middleNumberTextField.rx.text)
			.disposed(by: disposeBag)
		
		lastNumberTextField.rx.text.orEmpty
			.map { String($0.prefix(4)) }
			.bind(to: lastNumberTextField.rx.text)
			.disposed(by: disposeBag)
	}
	
	/// DropDown을 위한 Menu 선언부 입니다.
	func setupDropdownMenuButton() {
		viewModel.phoneNumbers
			.asDriver()
			.drive(onNext: { [weak self] numbersArray in
				guard let self else { return }
				if !numbersArray.isEmpty {
					firstNumberDropdownButton.setTitle(numbersArray[0], for: .normal)
				}
				
				let menus = makeButtonMenus(numbersArray)
				firstNumberDropdownButton.menu = UIMenu(children: menus)
			}).disposed(by: disposeBag)
	}
	
	func makeButtonMenus(_ firstNumbers: [String]) -> [UIMenuElement] {
		var menus: [UIMenuElement] = []
		for (index, firstNumber) in firstNumbers.enumerated() {
			let menu = UIAction(
				title: firstNumber,
				state: index == 0 ? .on : .off,
				handler: { _ in }
			)
			menus.append(menu)
		}
		return menus
	}
}
