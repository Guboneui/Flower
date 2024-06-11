//
//  OSLog+Extension.swift
//  UtilityKit
//
//  Created by 김동겸 on 6/9/24.
//

import OSLog

public extension OSLog {
	private static var subsystem = Bundle.main.bundleIdentifier ?? ""

	static let APIError = OSLog(subsystem: subsystem, category: "API")
}
