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
  
  init() {
    self.phoneNumbers = .init(value: [])
  }
}
