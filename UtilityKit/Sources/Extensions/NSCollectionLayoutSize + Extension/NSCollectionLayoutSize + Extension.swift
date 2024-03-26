//
//  NSCollectionLayoutSize + Extension.swift
//  UtilityKit
//
//  Created by 김민희 on 3/2/24.
//

import UIKit

public extension NSCollectionLayoutSize {
	static func fractionalSize() -> NSCollectionLayoutSize {
		.init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
	}
}
