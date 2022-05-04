//
//  MainViewController.swift
//  vican
//
//  Created by Oybek Melikulov on 5/4/22.
//

import UIKit
import AVFoundation
import NRSpeechToText

class MainViewController: UIViewController {
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		setup()
		checkMicPermission()
		
		self.timer = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: true, block: { _ in
			if !NRSpeechToText.shared.isRunning {
				guard let startText = self.startBtn.titleLabel?.text else {return}
				if startText == "Stop" {
					self.startRecording()
				}
			}
			guard let text = self.usersText.text else {return}
			if text.count > 70 {
				NRSpeechToText.shared.stop()
			}
		})
	}
	// MARK: - Properties
	var timer = Timer()
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
		label.text = "Press start to start!"
		label.numberOfLines = 4
		label.font = .systemFont(ofSize: 35)
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.allowsDefaultTighteningForTruncation = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private let resultText: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private let startBtn: UIButton = {
		let btn = UIButton()
		btn.setTitle("Start!", for: .normal)
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
			headerTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
			
			headerTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			
			headerTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
		])
		
		view.addSubview(usersText)
		NSLayoutConstraint.activate([
			usersText.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 10),
			usersText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
			usersText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
		])
		
		view.addSubview(resultText)
		NSLayoutConstraint.activate([
			resultText.topAnchor.constraint(equalTo: usersText.topAnchor, constant: 10),
			resultText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
			resultText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
		])
		
		view.addSubview(startBtn)
		NSLayoutConstraint.activate([
			startBtn.topAnchor.constraint(equalTo: resultText.bottomAnchor, constant: 10),
			
			startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			startBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			
			startBtn.heightAnchor.constraint(equalToConstant: 50),
			startBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
		])
	}
	private func setup() {
		startBtn.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
	}
}

// MARK: - NRSpeechToText
extension MainViewController {
	@objc private func startButtonPressed() {
		NRSpeechToText.shared.authorizePermission { (authorize) in
			if authorize {
				if NRSpeechToText.shared.isRunning {
					NRSpeechToText.shared.stop()
					
					OperationQueue.main.addOperation {
						self.startBtn.setTitle("Start", for: .normal)
					}
				}
				else {
					OperationQueue.main.addOperation {
						self.startBtn.setTitle("Stop", for: .normal)
					}
					self.startRecording()
				}
			}
		}
		
	}
	
	private func startRecording() {
		NRSpeechToText.shared.startRecording { (result: String?, isFinal: Bool, error: Error?) in
			if error != nil {
				print(error)
			}
			if error == nil {
				OperationQueue.main.addOperation {
					self.usersText.text = result
				}
			}
		}
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
