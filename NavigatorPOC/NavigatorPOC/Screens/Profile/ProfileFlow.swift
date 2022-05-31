//
//  ProfileFlow.swift
//  NavigatorPOC
//
//  Created by Goktug Aral on 30/05/2022.
//

import Foundation

class ProfileFlow: Destination {
   
    enum Destination {
        case logout
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .logout:
            missingSteps = ["email", "password", "phone", "id_verification"]
            OnboardingFlow().navigate(to: .inital)
        }
    }
}
