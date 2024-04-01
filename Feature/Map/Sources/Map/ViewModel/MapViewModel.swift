//
//  MapViewModel.swift
//  Map
//
//  Created by 김민희 on 3/4/24.
//

import UIKit

import ResourceKit

import RxRelay
import RxSwift

struct Model {
	let title: String
}

public final class MapViewModel {
	var mapCollectionViewItems: BehaviorRelay<[Model]> = .init(value: [
		.init(title: "title1"), .init(title: "title2"), .init(title: "title3")
	])
}
