//
//  OnboardingViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

class OnboardingViewModel {
    var didTapNext = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    private var onboardingFlow: OnboardingFlow
    
    init(onboardingFlow: OnboardingFlow = .development) {
        self.onboardingFlow = onboardingFlow
        
        didTapNext.sink { _ in
            let nextNavigation = onboardingFlow.getNextNavigation()
            AppEnvironment.Current.navigator.handle(navigation: nextNavigation)
        }.store(in: &subscriptions)
    }
}
