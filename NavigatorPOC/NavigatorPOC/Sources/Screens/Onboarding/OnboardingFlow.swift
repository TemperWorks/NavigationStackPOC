//
//  OnboardingFlowManager.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 16/5/22.
//

import Foundation
import UIKit

public struct OnboardingFlow: Flow {
    
    /// Define a set of supported destinations for Onboarding.
    enum Destination {
        case inital
        
        case email
        case password
        case phone
        case idVerification
        
        case main
    }
    
    /// Navigate to the  next screen based on the missing steps
    func navigate(to destination: Destination) {
        
        if destination == .inital {
            let screen = self.makeScreen(for: .email)
            AppEnvironment.Current.navigator.handle(navigation: .root(screen, isEmbededInNavigation: true))
            missingSteps.removeFirst()
        
        } else if destination == .main {
            let screen = self.makeScreen(for: .main)
            AppEnvironment.Current.navigator.handle(navigation: .root(screen))
        
        } else {
            let screen = self.makeScreen(for: destination)
            AppEnvironment.Current.navigator.handle(navigation: .push(screen))
        }
    }
    
    // MARK: - Private
    
    private func makeScreen(for destination: Destination?) -> Screen {
        
        switch destination {
        case .main:
            return .mainTabBar()
            
        case .email:
            return .email()
            
        case .password:
            return .password()
            
        case .phone:
            return .phone()
            
        case .idVerification:
            return .idVerification()
        
        default:
            return .mainTabBar()
        }
    }
}
