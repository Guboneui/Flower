//
//  HeaderSlideView.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/11/07.
//

import UIKit

import ResourceKit

import SnapKit
import Then

public class HeaderSlideView: UIView {
	
	// MARK: - HeaderSlideViewType
	public enum HeaderSlideViewType {
		case loginError
		
		var text: String {
			switch self {
			case .loginError:
				return "로그인에 실패하였습니다.\n비밀번호를 확인해주세요."
			}
		}
		
		var backgroundColor: UIColor {
			switch self {
			case .loginError:
				return AppTheme.Color.error
			}
		}
		
		var textColor: UIColor {
			switch self {
			case .loginError:
				return AppTheme.Color.white
			}
		}
		
		var font: UIFont {
			switch self {
			case .loginError:
				return AppTheme.Font.Regular_14
			}
		}
	}
	
	// MARK: - PUBLIC PROPERTY
	public var isActive: Bool {
		return parentVC != nil
	}
	
	// MARK: - PROPERTY
	private let type: HeaderSlideViewType
	private let duration: TimeInterval
	private let visibleTime: TimeInterval
	private var parentVC: UIViewController?
	
	// MARK: - UI PROPERTY
	private let titleLabel: UILabel = UILabel().then {
		$0.textAlignment = .center
	}
	
	public init(
		_ type: HeaderSlideViewType,
		duration: TimeInterval = 0.3,
		visibleTime: TimeInterval = 2.0
	) {
		self.type = type
		self.duration = duration
		self.visibleTime = visibleTime
		super.init(frame: .zero)
		setupViewConfigure()
		setupSubViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - PUBLIC METHOD
	
	/// 애니메이션을 시작하는 함수입니다.
	/// 실제 VC에서 사용하게 될 경우, .startAnimation(at: self)로 사용하면 됩니다.
	/// 해당 slideView는 별도 hide액션이 없으며, 시간 경과 후 자동으로 사라집니다
	/// 시간은 기본값이 지정되어 있지만 필요에 따라 주입해주면 됩니다.
	public func startAnimation(at parentVC: UIViewController) {
		if isActive == false {
			self.parentVC = parentVC
			setupInitialConfigure()
			setupInitialLayoutAtSuperView(at: parentVC)
			animateToShowDown()
		}
	}
}

// MARK: - PRIVATE METHOD
private extension HeaderSlideView {
	
	func setupViewConfigure() {
		backgroundColor = type.backgroundColor
		
		titleLabel.text = type.text
		titleLabel.textColor = type.textColor
		titleLabel.font = type.font
	}
	
	func setupSubViews() {
		addSubview(titleLabel)
		
		setupConstraints()
	}
	
	enum Metric {
		static let titleLabelTopMargin: CGFloat = UIDevice.hasNotch ? 52 : 24
		static let titleLabelBottomMargin: CGFloat = -12
	}
	
	func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(Metric.titleLabelTopMargin)
			make.bottom.equalToSuperview().offset(Metric.titleLabelBottomMargin)
			make.horizontalEdges.equalToSuperview()
		}
	}
	
	func setupInitialConfigure() {
		self.alpha = 0.0
	}
	
	func setupInitialLayoutAtSuperView(at parentVC: UIViewController) {
		parentVC.view.addSubview(self)
		
		self.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(parentVC.view.snp.top)
		}
		
		parentVC.view.layoutIfNeeded()
	}
	
	func animateToShowDown() {
		guard let parentVC else { return }
		let shownHeight: CGFloat = self.frame.height
		UIView.animate(
			withDuration: duration,
			delay: 0.0,
			options: .curveEaseOut,
			animations: {
				self.alpha = 1.0
				self.snp.updateConstraints { make in
					make.bottom.equalTo(parentVC.view.snp.top).offset(shownHeight)
				}
				parentVC.view.layoutIfNeeded()
			}, completion: { _ in
				self.animateToHideUp()
			}
		)
	}
	
	func animateToHideUp() {
		guard let parentVC else { return }
		UIView.animate(
			withDuration: duration,
			delay: visibleTime,
			options: .curveEaseOut,
			animations: {
				self.alpha = 0.0
				self.snp.updateConstraints { make in
					make.bottom.equalTo(parentVC.view.snp.top)
				}
				parentVC.view.layoutIfNeeded()
			}, completion: { _ in
				self.removeFromSuperview()
				self.snp.removeConstraints()
				self.parentVC = nil
			}
		)
	}
}
