//
//  OnboardingFlowManager.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 16/5/22.
//

import Foundation
import UIKit

public class OnboardingNavigator: Navigator {
	
	var initialMissingStep: MissingStepError
	var viewModels: [OnboardingViewModel] = []
	
	public required init(missingStep: MissingStepError, rootViewController: UIViewController) {
		self.initialMissingStep = missingStep
		super.init(rootViewController)
	}
	
	func start() {
		handleNextNavigation(missingStep: initialMissingStep)
	}
	
	func handleNextNavigation(missingStep: MissingStepError?) {
		guard let missingStep = missingStep else { return }
		let nextViewModel = self.viewModel(for: missingStep)
		self.viewModels.append(nextViewModel)
		self.handle(navigation: .push(nextViewModel))
	}
	
	func viewModel(for missingStep: MissingStepError) -> OnboardingViewModel {
		switch missingStep {
			case .email:
				return .init(title: "Email", nextHandler: handleNextNavigation)
			case .password:
				return .init(title: "Password", nextHandler: handleNextNavigation)
			case .phone:
				return .init(title: "Phone number", nextHandler: handleNextNavigation)
			case .idVerification:
				return .init(title: "ID Verification", nextHandler: handleNextNavigation)
		}
	}
}

import Combine

struct FakeProfileResource {
	let missingStep: MissingStepError?
	var get: Future<Bool, MissingStepError> {
		.init { promise in
			DispatchQueue.main.async {
				if let missingStep = missingStep {
					promise(.failure(missingStep))
				} else {
					promise(.success(true))
				}
			}
		}
	}
}

public enum MissingStepError: String, Error {
	case email, password, phone, idVerification
}

// Free functions for simulation purposes.
var missingSteps: [MissingStepError] = [.email, .password, .phone, .idVerification]
func nextMissingStep() -> MissingStepError? {
	missingSteps.isEmpty ? nil : missingSteps.removeFirst()
}
func simulateLogout() {
	missingSteps = [.email, .password, .phone, .idVerification]
}
func simulateLogIn() {
	missingSteps = []
}
