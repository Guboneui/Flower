//
//  MapViewModel.swift
//  Map
//
//  Created by 김민희 on 3/4/24.
//

import UIKit

import MapDomain
import MapEntity
import ResourceKit

import RxRelay
import RxSwift

public struct Model {
	let title: String
}

public protocol MapViewModelInterface {
	var mapCollectionViewItems: BehaviorRelay<[Model]> { get }

	func fetchAccommodationList()
}

public final class MapViewModel: MapViewModelInterface {

	private let MapUseCase: MapUseCaseInterface
	private var disposeBag: DisposeBag

	public var mapCollectionViewItems: BehaviorRelay<[Model]> = .init(value: [
		.init(title: "title1"), .init(title: "title2"), .init(title: "title3")
	])

	public init(useCase: MapUseCaseInterface) {
		self.MapUseCase = useCase
		self.disposeBag = .init()
	}

	public func fetchAccommodationList() {
		MapUseCase.fetchAccommodationList()
			.subscribe(onSuccess: { responseData in
				print(responseData)
			}).disposed(by: disposeBag)
	}

}
