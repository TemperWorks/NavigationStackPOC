//
//  ProfileViewModel.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 27/05/2022.
//

import Foundation
import Combine

class ProfileViewModel {
    var didTapLogout = PassthroughSubject<Int, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    private var onboardingFlow: OnboardingFlow
    
    init(onboardingFlow: OnboardingFlow = .development) {
        self.onboardingFlow = onboardingFlow
        
        didTapLogout.sink { _ in
            onboardingFlow.simulateLogout()
            let navigation = onboardingFlow.getFirstNavigation()
            AppEnvironment.Current.navigator.handle(navigation: navigation)
        }.store(in: &subscriptions)
    }
}
