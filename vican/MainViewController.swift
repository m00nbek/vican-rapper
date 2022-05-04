//
//  MainViewController.swift
//  vican
//
//  Created by Oybek Melikulov on 5/4/22.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		checkMicPermission()
	}
	// MARK: - Properties
	private let headerTitle: UILabel = {
		let label = UILabel()
		label.text = "Viçan"
		label.font = .preferredFont(forTextStyle: .largeTitle)
		label.textColor = .init(red: 0/255, green: 173/255, blue: 181/255, alpha: 1)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private let usersText: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .preferredFont(forTextStyle: .body)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private let resultText: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .preferredFont(forTextStyle: .body)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private let startBtn: UIButton = {
		let btn = UIButton()
		btn.setTitle("Start", for: .normal)
		btn.backgroundColor = .init(red: 0/255, green: 173/255, blue: 181/255, alpha: 1)
		btn.layer.cornerRadius = 8
		btn.translatesAutoresizingMaskIntoConstraints = false
		return btn
	}()
	// MARK: - Selectors
	// MARK: - API
	// MARK: - Functions
	private func configureUI() {
		view.backgroundColor = .init(red: 57/255, green: 62/255, blue: 70/255, alpha: 1)
		
		view.addSubview(headerTitle)
		NSLayoutConstraint.activate([
			headerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			
			headerTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
		])
		
		view.addSubview(usersText)
		NSLayoutConstraint.activate([
			usersText.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 10),
			usersText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			usersText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
		])
		
		view.addSubview(resultText)
		NSLayoutConstraint.activate([
			resultText.topAnchor.constraint(equalTo: usersText.topAnchor, constant: 10),
			resultText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			resultText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
		])
		
		view.addSubview(startBtn)
		NSLayoutConstraint.activate([
			startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			startBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			
			startBtn.heightAnchor.constraint(equalToConstant: 50),
			startBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
		])
				
	}
}

// MARK: - MicPermission
extension MainViewController {
	private func checkMicPermission() {
		switch AVAudioSession.sharedInstance().recordPermission {
			case .granted:
				print("Permission granted")
			case .denied:
				print("Permission denied")
			case .undetermined:
				print("Request permission here")
				AVAudioSession.sharedInstance().requestRecordPermission({ granted in
					// Handle granted
				})
			@unknown default:
				print("Unknown case")
		}
	}
}
