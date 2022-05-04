//
//  MainViewController.swift
//  vican
//
//  Created by Oybek Melikulov on 5/4/22.
//

import UIKit

class MainViewController: UIViewController {
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	// MARK: - Properties
	private let headerTitle: UILabel = {
		let label = UILabel()
		label.text = "Viçan"
		label.font = .preferredFont(forTextStyle: .largeTitle)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	// MARK: - Selectors
	// MARK: - API
	// MARK: - Functions
	private func configureUI() {
		view.backgroundColor = .init(red: 57/255, green: 62/255, blue: 70/255, alpha: 1)
		
		
		view.addSubview(headerTitle)
		NSLayoutConstraint.activate([
			headerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
		])
	}
}
