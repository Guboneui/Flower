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
  private struct Metric {
    let firstNumberLabelLeftMargin: CGFloat = 16
    let firstNumberLabelRightMargin: CGFloat = 8
    let dropDownImageSize: CGSize = CGSize(width: 24, height: 24)
    let dropDownImageRightMargin: CGFloat = -12
    let textFieldHorizontalMargin: CGFloat = 28
    let textFieldVerticalMargin: CGFloat = 18
  }
  
  private let firstNumberBaseView: UIView = UIView().then {
    $0.backgroundColor = .AppColor.appSecondary
    $0.makeCornerRadius(20)
    $0.clipsToBounds = false
  }
  
  private let firstNumberLabel: UILabel = UILabel().then {
    $0.font = .AppFont.Bold_20
    $0.textColor = .AppColor.appBlack
    $0.textAlignment = .left
    $0.text = "010"
  }
  
  private let dropDownImageView: UIImageView = UIImageView().then {
    $0.image = .AppImage.dropDown
    $0.contentMode = .scaleAspectFit
  }
  
  private let dropDownExtendableCollectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: .init()
  ).then {
    $0.backgroundColor = .AppColor.appSecondary
    $0.alpha = 0.0
    $0.showsVerticalScrollIndicator = false
    $0.makeCornerRadius(20, edge: .onlyBottom)
    $0.register(
      PhoneNumberListCell.self,
      forCellWithReuseIdentifier: PhoneNumberListCell.idendifier
    )
    $0.phoneNumberCollectionViewLayout()
  }
  
  private let middleNumberBaseView: UIView = UIView().then {
    $0.backgroundColor = .AppColor.appSecondary
    $0.makeCornerRadius(20)
  }
  
  private let middleNumberTextField: UITextField = UITextField().then {
    $0.font = .AppFont.Bold_20
    $0.textColor = .AppColor.appBlack
    $0.textAlignment = .center
    $0.keyboardType = .numberPad
  }
  
  private let lastNumberBaseView: UIView = UIView().then {
    $0.backgroundColor = .AppColor.appSecondary
    $0.makeCornerRadius(20)
  }
  
  private let lastNumberTextField: UITextField = UITextField().then {
    $0.font = .AppFont.Bold_20
    $0.textColor = .AppColor.appBlack
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
  
  private let metric: Metric
  private let viewModel: PhoneNumberInputViewModel
  private let disposeBag: DisposeBag
  
  // MARK: - INITIALIZE
  
  /// firstNumber가 될 수 있는 배열을 생성자에서 받습니다.
  public init(with firstPhoneNumbers: [String]) {
    self.metric = .init()
    self.disposeBag = .init()
    self.viewModel = PhoneNumberInputViewModelImpl()
    super.init(frame: .zero)
    viewModel.phoneNumbers.accept(firstPhoneNumbers)
    setupGestures()
    setupBindings()
    setupCollectionView()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setupSubViews()
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
  public func getUserPhoneNumber() -> (first: String, middle: String, last: String)? {
    if let first = firstNumberLabel.text,
       let middle = middleNumberTextField.text,
       let last = lastNumberTextField.text {
      return (first, middle, last)
    }
    return nil
  }
}

// MARK: - Private Method WITH LAYOUT
private extension PhoneNumberInputView {
  func setupSubViews() {
    firstNumberBaseView.addSubview(firstNumberLabel)
    firstNumberBaseView.addSubview(dropDownImageView)
    
    superview?.addSubview(dropDownExtendableCollectionView)
    
    middleNumberBaseView.addSubview(middleNumberTextField)
    lastNumberBaseView.addSubview(lastNumberTextField)
    
    addSubview(phoneNumberInputStackView)
    setupConstraints()
  }
  
  func setupConstraints() {
    
    firstNumberLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview()
				.offset(metric.firstNumberLabelLeftMargin)
      make.trailing.equalTo(dropDownImageView.snp.leading)
				.offset(metric.firstNumberLabelRightMargin)
      make.verticalEdges.equalToSuperview()
				.inset(metric.textFieldVerticalMargin)
    }
    
    dropDownImageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview().offset(metric.dropDownImageRightMargin)
      make.size.equalTo(metric.dropDownImageSize)
    }
    
    dropDownExtendableCollectionView.snp.makeConstraints { make in
      make.top.equalTo(firstNumberLabel.snp.bottom)
      make.horizontalEdges.equalTo(firstNumberBaseView.snp.horizontalEdges)
      make.height.equalTo(0)
    }
    
    middleNumberTextField.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(metric.textFieldHorizontalMargin)
      make.verticalEdges.equalToSuperview().inset(metric.textFieldVerticalMargin)
    }
    
    lastNumberTextField.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(metric.textFieldHorizontalMargin)
      make.verticalEdges.equalToSuperview().inset(metric.textFieldVerticalMargin)
    }
    
    phoneNumberInputStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func setupGestures() {
    firstNumberBaseView.rx.tapGesture()
      .when(.recognized)
      .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
      .bind { [weak self] _ in
        guard let self else { return }
        viewModel.isDisplayDropDown.accept(!getDropDownDisplayState())
      }.disposed(by: disposeBag)
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
    
    // 드롭다운과 관련한 애니메이션을 처리합니다.
    viewModel.isDisplayDropDown
      .asDriver()
      .skip(1)
      .drive(onNext: { [weak self] isDisplay in
        guard let self else { return }
        UIView.animate(
          withDuration: 0.25,
          animations: {
            self.dropDownExtendableCollectionView.alpha = isDisplay ? 1.0 : 0.0
            self.dropDownExtendableCollectionView.snp.remakeConstraints { make in
              make.top.equalTo(self.firstNumberLabel.snp.bottom)
              make.horizontalEdges.equalTo(self.firstNumberBaseView.snp.horizontalEdges)
              make.height.equalTo(isDisplay ? 120 : 0)
            }
            self.superview?.layoutIfNeeded()
          }
        )
      }).disposed(by: disposeBag)
  }
  
  /// DropDown을 위한 UICollectionView 선언부 입니다.
  func setupCollectionView() {
    viewModel.phoneNumbers
      .asDriver()
      .drive(dropDownExtendableCollectionView.rx.items(
        cellIdentifier: PhoneNumberListCell.idendifier,
        cellType: PhoneNumberListCell.self
      )) { _, phoneNumber, cell in
        UIView.performWithoutAnimation {
          /// cell의 애니메이션을 명시적으로 비활성화 합니다.
          /// collectionView 최초 높이 변경 시 cell 내부에도 애니메이션이 적용되는 현상을 막습니다.
          cell.layoutIfNeeded()
        }
        cell.setupCellConfigure(number: phoneNumber)
      }.disposed(by: disposeBag)
    
    dropDownExtendableCollectionView.rx.modelSelected(String.self)
      .observe(on: MainScheduler.instance)
      .bind { [weak self] phoneNumber in
        guard let self else { return }
        firstNumberLabel.text = phoneNumber
        viewModel.isDisplayDropDown.accept(!getDropDownDisplayState())
      }.disposed(by: disposeBag)
  }
  
  func getDropDownDisplayState() -> Bool {
    viewModel.isDisplayDropDown.value
  }
}
