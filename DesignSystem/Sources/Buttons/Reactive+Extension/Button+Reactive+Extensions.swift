//
//  Button+Reactive+Extensions.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/11/18.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UIButton {
	public enum ButtonThrottleDuration: Int {
		case low = 300
		case middle = 500
		case high = 750
	}
	
	public func touchHandler(
		throttleDuration: ButtonThrottleDuration = .low
	) -> ControlEvent<Void> {
		let event = base.rx.tap
			.throttle(
				.milliseconds(throttleDuration.rawValue),
				latest: false, 
				scheduler: MainScheduler.instance
			)
		return ControlEvent(events: event)
	}
}
