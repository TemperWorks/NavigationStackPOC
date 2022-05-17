//
//  OnboardingFlowManager.swift
//  NavigatorPOC
//
//  Created by Alejandro Luján López on 16/5/22.
//

import Foundation
import UIKit

public struct OnboardingFlow {
    
    var getMissingStep: () async -> String?
    
    public init(getMissingStep: @escaping () async -> String?) {
        self.getMissingStep = getMissingStep
    }
    
    // This is to mock the service behaviour
    private static var missingSteps = ["email", "password", "phone", "id_verification"]
    
    func simulateLogout() {
        OnboardingFlow.missingSteps = ["email", "password", "phone", "id_verification"]
    }
    
    func simulateCompletion() {
        OnboardingFlow.missingSteps.removeAll()
    }
    
    private func getNextScreen() async -> Screen? {
        let step = await getMissingStep()
        
        switch step {
        case "email":
            return .email()
            
        case "password":
            return .password()
            
        case "phone":
            return .phone()
            
        case "id_verification":
            return .idVerification()
        default:
            return nil
        }
    }
    
    /// Picks the next screen based on missing steps and embeds it in a `UINavigationViewController`
    ///
    /// - Returns: The first `Navigation` object for this flow
    func getFirstNavigation() async -> Navigation {
        guard let nextScreen = await getNextScreen() else {
            let screen = Screen.shiftOverviewTabBar()
            return .root(screen)
        }
        
        let navigation = Screen.init{
            let vc = nextScreen.viewController()
            let navigationController = UINavigationController(rootViewController: vc)
            return navigationController
        }
        
        return .root(navigation)
    }
    
    /// Picks the next screen based on the missing steps
    ///
    /// - Returns the next `Navigation` for this flow
    ///     * Push for onboarding screens
    ///     * Roor for the shift overview
    func getNextNavigation() async -> Navigation {
        guard let nextScreen = await getNextScreen() else {
            let screen = Screen.shiftOverviewTabBar()
            return .root(screen)
        }
        
        return .push(nextScreen)
    }
}

extension OnboardingFlow {
    
    public static let live = Self {
        return "Something returned from backend"
    }
    
    public static let development = Self {
        if let step = OnboardingFlow.missingSteps.first {
            OnboardingFlow.missingSteps.removeFirst()
            return step
        }
        
        return nil
    }
    
    public static let alwaysCompleted = Self {
        return nil
    }

}
