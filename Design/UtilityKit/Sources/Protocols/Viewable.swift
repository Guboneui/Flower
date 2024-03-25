//
//  Viewable.swift
//  UtilityKit
//
//  Created by 구본의 on 3/26/24.
//

import Foundation

public protocol Viewable {
	func setupConfigures()
	func setupViews()
	func setupConstraints()
	func setupBinds()
}

public extension Viewable {
	func setupBinds() { }
}
