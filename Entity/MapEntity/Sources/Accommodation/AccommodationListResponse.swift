//
//  AccommodationListResponse.swift
//  MapEntity
//
//  Created by 김민희 on 6/5/24.
//

import Foundation

public struct AccommodationListResponse: Codable {
	public let id: Int
	public let name: String
	public let description: String
	public let thumbnail: String
	public let reviewStar: Double
	public let reviewCnt: Int
	public let minPrice: Int
	public let lat: Double
	public let lng: Double
}
