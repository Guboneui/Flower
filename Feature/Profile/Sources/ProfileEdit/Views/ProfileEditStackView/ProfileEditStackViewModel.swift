//
//  ProfileEditStackViewModel.swift
//  Profile
//
//  Created by 구본의 on 2024/03/07.
//

import UIKit

struct ProfileEditStackViewModel: Equatable {
	let title: String
	let contents: String
	let image: UIImage?
	let isEditable: Bool
	
	init(
		title: String = "",
		contents: String = "",
		image: UIImage? = nil,
		isEditable: Bool = false
	) {
		self.title = title
		self.contents = contents
		self.image = image
		self.isEditable = isEditable
	}
}
