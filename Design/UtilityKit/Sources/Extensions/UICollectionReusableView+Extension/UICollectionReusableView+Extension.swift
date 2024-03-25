//
//  UICollectionReusableView+Extension.swift
//  UtilityKit
//
//  Created by 구본의 on 3/26/24.
//

import UIKit

public protocol ReusablIdentifierProtocol {
		static var identifier: String { get }
}

extension UICollectionViewCell: ReusablIdentifierProtocol {
	public static var identifier: String {
		return String(describing: self)
	}
}
