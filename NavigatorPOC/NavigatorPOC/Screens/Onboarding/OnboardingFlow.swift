//
//  OnboardingFlowManager.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 16/5/22.
//

import Foundation
import UIKit

public class OnboardingFlow: Navigator {
	
	private var cancellables = Set<AnyCancellable>()
	
	func start() {
		handleNextNavigation()
	}
	
	func handleNextNavigation() {
		FakeProfileResource(missingStep: nextMissingStep())
			.get
			.sink { [weak self] result in
				guard let self = self else { return }
				if case .failure(let error) = result {
					let nextViewModel = self.viewModel(for: error)
					self.handle(navigation: .push(nextViewModel))
				}
			} receiveValue: { _ in
				AppEnvironment.Current.session.value = .init()
			}
			.store(in: &cancellables)
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
