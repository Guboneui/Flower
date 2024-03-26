//
//  MapViewModel.swift
//  Map
//
//  Created by 김민희 on 3/4/24.
//

import RxRelay
import RxSwift

struct Model {
	let title: String
}

public final class MapViewModel {
	var collectionViewItems: BehaviorRelay<[Model]> = .init(value: [
		.init(title: "title1"), .init(title: "title"), .init(title: "title"),
	])
}
