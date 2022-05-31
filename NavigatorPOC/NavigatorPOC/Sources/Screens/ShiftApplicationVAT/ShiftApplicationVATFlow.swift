//
//  ShiftApplicationVATFlow.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 31/05/2022.
//

import Foundation

class ShiftApplicationVATFlow: Destination {
    
    enum Destination {
        case main
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .main:
            missingSteps = ["email", "password", "phone", "id_verification"]
            OnboardingFlow().navigate(to: .main)
        }
    }
}
