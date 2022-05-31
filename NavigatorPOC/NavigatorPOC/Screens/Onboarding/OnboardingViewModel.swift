//
//  OnboardingViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

// This is to mock the service behaviour
var missingSteps = ["email", "password", "phone", "id_verification"]

class OnboardingViewModel {
    var didTapNext = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    private let onboardingFlow = OnboardingFlow()
    
    init() {
  
        didTapNext.sink { [weak self] _ in
            guard let self = self else { return }
            
            self.fetch().sink { value in
                self.onboardingFlow.navigate(to: value)
                
                if !missingSteps.isEmpty {
                    missingSteps.removeFirst()
                }
                
            }.store(in: &self.subscriptions)
           
        }.store(in: &subscriptions)
    }
    
    // MARK: Fetching..
    func fetch() -> AnyPublisher<OnboardingFlow.Destination, Never> {
        return Just(missingSteps.first ?? "none")
            .map { resolveStep(value: $0)}
            .eraseToAnyPublisher()
    }

    private func resolveStep(value: String) -> OnboardingFlow.Destination {
        
        switch value {
        case "email":
            return .email
            
        case "password":
            return .password
            
        case "phone":
            return .phone
            
        case "id_verification":
            return .idVerification
        default:
            return .main
        }
    }
}
