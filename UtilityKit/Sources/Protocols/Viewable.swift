//
//  Viewable.swift
//  UtilityKit
//
//  Created by 구본의 on 2023/12/26.
//

import Foundation

public protocol Viewable {
	func setupConfigures()
	func setupViews()
	func setupConstraints()
	func setupBinds()
}
