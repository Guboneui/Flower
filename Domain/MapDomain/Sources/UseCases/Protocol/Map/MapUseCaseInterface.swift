//
//  MapUseCaseInterface.swift
//  MapDomain
//
//  Created by 김민희 on 6/5/24.
//

import Foundation

import MapEntity
import NetworkHelper

import RxSwift

public protocol MapUseCaseInterface {
	func fetchAccommodationList() -> Single<[AccommodationListResponse]>
}
