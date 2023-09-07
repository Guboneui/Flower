//
//  RootViewController.swift
//  App
//
//  Created by 구본의 on 2023/09/08.
//

import UIKit

final class RootViewController: UIViewController {
	
	private let rootLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Hello World"
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	private func setupViews() {
		view.backgroundColor = .white
		
		view.addSubview(rootLabel)
		setupConstraints()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			rootLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			rootLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
}
