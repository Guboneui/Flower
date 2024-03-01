//
//  UICollectionViewCell + Extension.swift
//  UtilityKit
//
//  Created by 김동겸 on 1/24/24.
//

import UIKit

public protocol ReusablIdentifierProtocol {
		static var identifier: String { get }
}

extension UICollectionReusableView: ReusablIdentifierProtocol {
	public static var identifier: String {
		return String(describing: self)
	}
}
