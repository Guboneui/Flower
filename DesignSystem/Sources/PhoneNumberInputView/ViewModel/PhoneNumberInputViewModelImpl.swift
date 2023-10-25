//
//  PhoneNumberInputViewModelImpl.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/25.
//

import Foundation

import RxRelay

internal class PhoneNumberInputViewModelImpl: PhoneNumberInputViewModel {
  let phoneNumbers: BehaviorRelay<[String]>
  let isDisplayDropDown: RxRelay.BehaviorRelay<Bool>
  
  init() {
    self.phoneNumbers = .init(value: [])
    self.isDisplayDropDown = .init(value: false)
  }
}
