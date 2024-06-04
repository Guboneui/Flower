//
//  MapRepository.swift
//  MapData
//
//  Created by 김민희 on 6/5/24.
//


import Foundation

import MapDomain
import MapEntity
import MapService
import NetworkHelper

import RxSwift

public final class MapRepository: NetworkRepository<MapAPI>, MapRepositoryInterface {
	public func fetchAccommodationListAPI() -> Single<[AccommodationListResponse]> {
		request(endPoint: .accommodationList)
	}

	public init() {
		super.init(networkProvider: NetworkProvider())
	}
}
