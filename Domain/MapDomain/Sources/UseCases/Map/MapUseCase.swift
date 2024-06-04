//
//  MapUseCase.swift
//  MapDomain
//
//  Created by 김민희 on 6/5/24.
//

import Foundation

import MapEntity
import NetworkHelper

import RxSwift

public final class MapUseCase: MapUseCaseInterface {

	private let MapRepository: MapRepositoryInterface

	public init(MapRepository: MapRepositoryInterface) {
		self.MapRepository = MapRepository
	}

	public func fetchAccommodationList() -> Single<[AccommodationListResponse]> {
		return MapRepository.fetchAccommodationListAPI()
	}
}
