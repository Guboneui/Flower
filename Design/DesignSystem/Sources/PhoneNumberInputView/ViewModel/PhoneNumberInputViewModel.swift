//
//  PhoneNumberInputViewModel.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/25.
//

import Foundation

import RxRelay

internal protocol PhoneNumberInputViewModel {
  var phoneNumbers: BehaviorRelay<[String]> { get }
}
